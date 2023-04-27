import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/add_expense.dart';
import 'package:split_rex/src/model/friends.dart';

import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/providers/transaction.dart';

import '../common/const.dart';
import './group.dart';

import '../common/logger.dart';
import '../providers/add_expense.dart';

class AddExpenseServices {
  String endpoint = getUrl();
  // String endpoint = "http://localhost:8080";

  Future<void> createGroup(WidgetRef ref) async {
    NewGroup newGroup = ref.watch(addExpenseProvider).newGroup;

    Response resp = await post(Uri.parse("$endpoint/userCreateGroup"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
        },
        body: jsonEncode(<String, dynamic>{
          "name": newGroup.name,
          "member_id": newGroup.memberId,
          "start_date": DateTime.parse(newGroup.startDate).toUtc().toIso8601String(),
          "end_date": DateTime.parse(newGroup.endDate).toUtc().toIso8601String()
        }));
    var data = jsonDecode(resp.body);
    logger.d(data);
    if (data["message"] == "SUCCESS") {
      await GroupServices().getGroupDetail(ref, data["data"]);
      await GroupServices().userGroupList(ref);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> createTransaction(WidgetRef ref, BuildContext context) async {
    Transaction newBill = ref.watch(addExpenseProvider).newBill;
    newBill.billOwner = ref.watch(authProvider).userData.userId;
    newBill.groupId = ref.watch(groupListProvider).currGroup.groupId;
    newBill.items = ref.watch(addExpenseProvider).items;

    var itemsObj = [];

    for (Items item in newBill.items) {
      itemsObj.add({
        "name": item.name,
        "quantity": item.qty,
        "price": item.price,
        "consumer": item.consumer
      });
    }

    Response resp = await post(Uri.parse("$endpoint/userCreateTransaction"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
        },
        body: jsonEncode(<String, dynamic>{
          "name": newBill.name,
          "description": newBill.desc,
          "group_id": newBill.groupId,
          "date": DateTime.parse(newBill.date).toUtc().toIso8601String(),
          "subtotal": newBill.subtotal,
          "tax": newBill.tax,
          "service": newBill.service,
          "total": newBill.total,
          "bill_owner": newBill.billOwner,
          "items": itemsObj
        }));
    var data = jsonDecode(resp.body);
    logger.d(data);
    if (data["message"] == "SUCCESS") {
      // ignore: use_build_context_synchronously
      updatePayment(ref, context);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> updatePayment(WidgetRef ref, BuildContext context) async {
    List<Items> items = ref.watch(addExpenseProvider).items;
    String currGroupId = ref.watch(groupListProvider).currGroup.groupId;

    // for every item, check its consumer
    // divide total price with number of consumer
    // check if uid is already in list payment
    // skip if uid is bill owner's
    var listPaymentObj = {};
    for (var i = 0; i < items.length; i++) {
      var consumer = items[i].consumer;
      var owedPerPerson = items[i].total / consumer.length;
      for (var j = 0; j < consumer.length; j++) {
        var consumerId = consumer[j];
        if (listPaymentObj.containsKey(consumerId)) {
          listPaymentObj[consumerId] += owedPerPerson;
        } else {
          listPaymentObj[consumerId] = owedPerPerson;
        }
      }
    }
    var listPayment = [];
    listPaymentObj.forEach((key, value) {
      if (key != ref.watch(authProvider).userData.userId) {
        listPayment.add({
          "user_id": key,
          "total_unpaid": 
            value
            + ref.watch(addExpenseProvider).newBill.tax / listPaymentObj.length
            + ref.watch(addExpenseProvider).newBill.service / listPaymentObj.length
        });
      }
    });

    logger.d(listPayment);

    Response resp = await post(Uri.parse("$endpoint/updatePayment"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
        },
        body: jsonEncode(<String, dynamic>{
          "group_id": currGroupId,
          "list_payment": listPayment
        }));
    var data = jsonDecode(resp.body);
    logger.d(data);
    if (data["message"] == "SUCCESS") {
      // ignore: use_build_context_synchronously
      resolveTransaction(ref, context);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> resolveTransaction(WidgetRef ref, BuildContext context) async {
    String currGroupId = ref.watch(groupListProvider).currGroup.groupId;

    Response resp = await post(Uri.parse("$endpoint/resolveTransaction"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
        },
        body: jsonEncode(<String, dynamic>{
          "group_id": currGroupId,
        }));
    var data = jsonDecode(resp.body);
    logger.d(data);
    if (data["message"] == "SUCCESS") {
      ref.watch(addExpenseProvider).resetAll();      
      GroupServices().getGroupTransactions(ref).then((value) {
        ref.read(routeProvider).changeNavbarIdx(context, 1);
        ref.read(routeProvider).changePage(context, "/group_detail");
      });
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> getTransactionDetail(WidgetRef ref, String transactionId, BuildContext context) async {
    Response resp = await get(Uri.parse("$endpoint/getTransactionDetail?transaction_id=$transactionId"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
        });
    var data = jsonDecode(resp.body);
    logger.d(data);
    if (data["message"] == "SUCCESS") {
      var trans = data["data"];
      var transItem = trans["items"];

      Transaction newTrans = Transaction();
      newTrans.name = trans["name"];
      newTrans.groupName = trans["group_name"];
      newTrans.date = trans["date"];
      newTrans.subtotal = trans["subtotal"];
      newTrans.tax = trans["tax"];
      newTrans.service = trans["service"];
      newTrans.total = trans["total"];

      for (var i = 0; i < transItem.length; i++) {
        Items tempItem = Items();
        tempItem.name = transItem[i]["name"];
        tempItem.qty = transItem[i]["quantity"];
        tempItem.price = transItem[i]["price"];
        tempItem.total = transItem[i]["total_price"];
        var transConsumer = transItem[i]["consumer"];
        for (var j = 0; j < transConsumer.length; j++) {
          Friend tempConsumer = Friend();
          tempConsumer.userId = transConsumer[j]["user_id"];
          tempConsumer.name = transConsumer[j]["name"];
          tempConsumer.color = transConsumer[j]["color"];
          tempItem.consumerDetails.add(tempConsumer);
        }
        newTrans.items.add(tempItem);
      }
      ref.read(transactionProvider).changeTrans(newTrans);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }
}
