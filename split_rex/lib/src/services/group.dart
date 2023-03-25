import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:split_rex/src/model/add_expense.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/providers/group_list.dart';

import '../common/logger.dart';
import '../providers/auth.dart';

class GroupServices {
  String endpoint = "https://split-rex-backend-7v6i6rndga-et.a.run.app";

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
    if (data["message"] == "SUCCESS") {
      var transactions = data["data"];
      List<Transaction> newTransList = [];
      for (var i = 0; i < transactions.length; i++) {
        var currTrans = transactions[i];
        var tempTrans = Transaction();
        tempTrans.billOwner = currTrans["bill_owner"];
        tempTrans.groupId = currTrans["group_id"];
        tempTrans.name = currTrans["name"];
        tempTrans.total = currTrans["total"];
        newTransList.add(tempTrans);
      }
      ref.watch(groupListProvider).changeCurrGroupTransactions(newTransList);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> getGroupOwed(WidgetRef ref) async {
    final String response =
        await rootBundle.loadString('assets/groupsOwed.json');
    var data = await json.decode(response);
    logger.d(data["data"]);
    var isempty = false;
    for (var i = 0; i < data["data"].length; i++) {
      if (data["data"][i]["type"] != "HARDCODED") {
        isempty = true;
      }
    }
    ref.read(groupListProvider).updateHasOwedGroups(isempty);
  }

  Future<void> getGroupLent(WidgetRef ref) async {
    final String response =
        await rootBundle.loadString('assets/groupLent.json');
    var data = await json.decode(response);
    ref.read(groupListProvider).updateHasLentGroups(data["data"].isNotEmpty);
  }

  Future<void> editGroupInfo(WidgetRef ref, String groupId, String newGroupName) async {
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
}
