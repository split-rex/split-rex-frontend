import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:split_rex/src/model/add_expense.dart';
import 'package:split_rex/src/model/group_model.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/providers/group_settings.dart';
import 'package:split_rex/src/providers/routes.dart';

import '../common/const.dart';
import '../common/logger.dart';
import '../providers/auth.dart';

class GroupServices {
  String endpoint = getUrl();
  // String endpoint = "http://localhost:8080";

  Future<void> userGroupList(WidgetRef ref) async {
    Response resp = await get(
      Uri.parse("$endpoint/userGroups"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(groupListProvider).loadGroupData(data["data"]);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> getGroupDetail(WidgetRef ref, String groupId) async {
    Response resp = await get(
      Uri.parse("$endpoint/groupDetail?id=$groupId"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(groupListProvider).changeCurrGroupDetail(data["data"]);
      await getGroupTransactions(ref);
      await getGroupActivity(ref);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> getGroupActivity(WidgetRef ref) async {
    String groupId = ref.watch(groupListProvider).currGroup.groupId;
    Response resp = await get(
      Uri.parse("$endpoint/getGroupActivity?id=$groupId"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      var activities = data["data"];
      List<GroupActivity> newActivityList = [];
      if (activities != null) {
        try {
          for (var i = 0; i < activities.length; i++) {
            var currActivity = activities[i];
            var tempActivity = GroupActivity(
              currActivity["activity_id"],
              currActivity["date"],
              currActivity["name1"],
              currActivity["name2"],
              currActivity["amount"] * 1.0,
            );
            newActivityList.add(tempActivity);
          }
          ref.watch(groupListProvider).changeCurrGroupActivity(newActivityList);
        } catch (error) {
          logger.d(error);
        }
      }
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> getGroupTransactions(WidgetRef ref) async {
    String groupId = ref.watch(groupListProvider).currGroup.groupId;
    Response resp = await get(
      Uri.parse("$endpoint/groupTransactions?id=$groupId"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);

    logger.d(data);
    // logger.d(data["data"].sublist(0, data["data"].length)["date"]);
    if (data["message"] == "SUCCESS") {
      var transactions = data["data"];
      List<Transaction> newTransList = [];
      if (transactions != null) {
        try {
          for (var i = 0; i < transactions.length; i++) {
            var currTrans = transactions[i];
            var tempTrans = Transaction();
            tempTrans.groupId = groupId;
            tempTrans.transactionId = currTrans["transaction_id"];
            tempTrans.billOwner = currTrans["bill_owner"];
            tempTrans.name = currTrans["name"];
            tempTrans.date = currTrans["date"];
            newTransList.add(tempTrans);
          }
          ref.watch(groupListProvider).changeCurrGroupTransactions(newTransList);
        } catch (error) {
          logger.d(error);
        }
      }
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> getGroupTransactionsActivity(
      WidgetRef ref, String groupId) async {
    Response resp = await get(
      Uri.parse("$endpoint/groupTransactions?id=$groupId"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);
    logger.d(data);
    if (data["message"] == "SUCCESS") {
      var transactions = data["data"];
      List<Transaction> newTransList = [];
      if (transactions != null) {
        try {
          for (var i = 0; i < transactions.length; i++) {
            var currTrans = transactions[i];
            var tempTrans = Transaction();
            tempTrans.groupId = groupId;
            tempTrans.transactionId = currTrans["transaction_id"];
            tempTrans.billOwner = currTrans["bill_owner"];
            tempTrans.name = currTrans["name"];
            tempTrans.date = currTrans["date"];
            newTransList.add(tempTrans);
          }
          ref.watch(groupListProvider).changeCurrGroupTransactions(newTransList);
        } catch (error) {
          logger.d(error);
        }
      }
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<dynamic> getGroupOwed(String jwtToken) async {
    Response response = await get(
      Uri.parse("$endpoint/userGroupOwed"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $jwtToken"
      },
    );
    var data = await json.decode(response.body);
    return data;
  }

  Future<dynamic> getGroupLent(String jwtToken) async {
    Response response = await get(
      Uri.parse("$endpoint/userGroupLent"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $jwtToken"
      },
    );
    var data = await json.decode(response.body);
    return data;
  }

  Future<void> editGroupInfo(
    WidgetRef ref, String groupId, String newGroupName) async {
    Response resp = await post(
      Uri.parse("$endpoint/editGroupInfo"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
      body: jsonEncode({
        "group_id": groupId,
        "name": newGroupName,
      }),
    );
    var data = jsonDecode(resp.body);
    var logger = Logger();
    logger.d(data);
    if (data["message"] == "SUCCESS") {
      await getGroupDetail(ref, groupId);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> addFriendToGroup(WidgetRef ref, BuildContext context) async {
    Response resp = await post(
      Uri.parse("$endpoint/addGroupMember"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
      body: jsonEncode({
        "group_id": ref.watch(groupListProvider).currGroup.groupId,
        "friends_id": ref.watch(groupSettingsProvider).memberId,
      }),
    );
    var data = jsonDecode(resp.body);
    var logger = Logger();
    logger.d(data);
    log(data["message"]);
    if (data["message"] == "SUCCESS") {
      getGroupDetail(ref, ref.watch(groupListProvider).currGroup.groupId).then((value) {
        ref.read(routeProvider).changePage(context, "/group_settings");
      });
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }
}

final groupServicesProvider = Provider<GroupServices>((ref) => GroupServices());

Future<void> getGroupOwedLent(WidgetRef ref) async {
  var groupsOwed = await ref.read(groupServicesProvider).getGroupOwed(
    ref.watch(authProvider).jwtToken
  );
  var groupsLent = await ref.read(groupServicesProvider).getGroupLent(
    ref.watch(authProvider).jwtToken
  );
  
  if (groupsOwed["message"] == "SUCCESS") {
    ref.read(groupListProvider).updateHasOwedGroups(groupsOwed["data"]["list_group"].isNotEmpty);
  } else {
    ref.read(errorProvider).changeError(groupsOwed["message"]);
  }

  if (groupsLent["message"] == "SUCCESS") {
    logger.d(groupsLent);
    ref.read(groupListProvider).updateHasLentGroups(groupsLent["data"]["list_group"].isNotEmpty);
  } else {
    ref.read(errorProvider).changeError(groupsLent["message"]);
  }
}
