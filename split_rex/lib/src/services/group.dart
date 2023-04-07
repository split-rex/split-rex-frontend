import 'dart:convert';

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
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> getGroupTransactionsActivity(WidgetRef ref, String groupId) async {
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
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<bool> getGroupOwed(String jwtToken) async {
    Response response = await get(
      Uri.parse("$endpoint/userGroupOwed"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $jwtToken"
      },
    );
    var data = await json.decode(response.body);
    // logger.d(data["data"]);
    return data["data"]["list_group"].isNotEmpty;
  }

  Future<bool> getGroupLent(String jwtToken) async {
    Response response = await get(
      Uri.parse("$endpoint/userGroupLent"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer $jwtToken"
      },
    );
    var data = await json.decode(response.body);
    // logger.d(data["data"]);
    return (data["data"]["list_group"].isNotEmpty);
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

final groupServicesProvider = Provider<GroupServices>(
  (ref) => GroupServices()
);

final getGroupOwedLent = FutureProvider.family<bool, bool>((ref, isOwed) async {
  if (isOwed) {
    return ref.read(groupServicesProvider).getGroupOwed(
      ref.watch(authProvider).jwtToken
    );
  } else {
    return ref.read(groupServicesProvider).getGroupLent(
      ref.watch(authProvider).jwtToken
    );
  }
});
