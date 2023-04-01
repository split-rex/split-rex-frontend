import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/add_expense.dart';

import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/providers/transaction.dart';

import './group.dart';

import '../common/logger.dart';
import '../providers/add_expense.dart';

class AddExpenseServices {
  String endpoint = "https://split-rex-backend-7v6i6rndga-et.a.run.app";

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

  Future<void> createTransaction(WidgetRef ref) async {
    Transaction newBill = ref.watch(addExpenseProvider).newBill;
    newBill.billOwner = ref.watch(authProvider).userData.userId;
    newBill.groupId = ref.watch(groupListProvider).currGroup.groupId;
    newBill.items = ref.watch(addExpenseProvider).items;
    // print("YOYOMA");
    // print(newBill.billOwner);
    // print(newBill.date);
    // print(newBill.desc);
    // print(newBill.groupId);
    // print(newBill.items);
    // print(newBill.name);
    // print(newBill.service);
    // print(newBill.subtotal);
    // print(newBill.tax);
    // print(newBill.total);
    // print("YOYOMA");

    var itemsObj = {};

    for (Items item in newBill.items) {
      itemsObj[item.name] = {
        "quantity": item.qty,
        "price": item.price,
        "consumere": item.consumer
      };
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
        }));
    var data = jsonDecode(resp.body);
    logger.d(data);
    if (data["message"] == "SUCCESS") {
      await updatePayment(ref);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> updatePayment(WidgetRef ref) async {
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
      await resolveTransaction(ref);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> resolveTransaction(WidgetRef ref) async {
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
      ref.read(routeProvider).changeNavbarIdx(1);
      await GroupServices().getGroupTransactions(ref);
      ref.read(routeProvider).changePage("group_detail");
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> getTransactionDetail(WidgetRef ref, String transactionId) async {
    // String currGroupId = ref.watch(groupListProvider).currGroup.groupId;

    // Response resp = await get(Uri.parse("$endpoint/getTransactionDetail?transaction_id=$transactionId"),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json',
    //       "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
    //     });
    // var data = jsonDecode(resp.body);
    // logger.d(data);
    // if (data["message"] == "SUCCESS") {
      // TODO: ini
      Items itemA = Items();
      Items itemB = Items();
      Items itemC = Items();

      itemA.name = "Item A";
      itemB.name = "Item B";
      itemC.name = "Item C";

      itemA.price = 62000;
      itemB.price = 52000;
      itemC.price = 42000;

      itemA.total = 62000;
      itemB.total = 52000;
      itemC.total = 42000;

      itemA.qty = 1;
      itemB.qty = 1;
      itemC.qty = 1;

      Transaction newTrans = Transaction();

      newTrans.name = "Transaksi Shay";
      newTrans.groupName = "Group shay";
      newTrans.date = "03 Feb 2023";

      newTrans.items = [itemA, itemB, itemC];

      newTrans.subtotal = 1;
      newTrans.tax = 2;
      newTrans.service = 3;
      newTrans.total = 4;
      
      ref.read(transactionProvider).changeTrans(newTrans);
      ref.read(routeProvider).changePage("transaction_detail");
    // } else {
    //   ref.read(errorProvider).changeError(data["message"]);
    // }
  }
}
