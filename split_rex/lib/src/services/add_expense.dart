import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/add_expense.dart';

import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/providers/routes.dart';

import './group.dart';

import '../common/logger.dart';
import '../providers/add_expense.dart';

class FriendServices {
  String endpoint = "https://split-rex-backend-7v6i6rndga-et.a.run.app";

  Future<void> createGroup(WidgetRef ref) async {
    NewGroup newGroup = ref.watch(addExpenseProvider).newGroup;
    // TODO: cek bener ga ini
    // newGroup.memberId.add(ref.watch(authProvider).userData.userId);

    Response resp = await post(Uri.parse("$endpoint/userCreateGroup"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
        },
        body: jsonEncode(<String, dynamic>{
          "name": newGroup.name,
          "member_id": newGroup.memberId,
          // TODO: utc
          "start_date": newGroup.startDate,
          "end_date": newGroup.endDate
        }));
    var data = jsonDecode(resp.body);
    logger.d(data);
    if (data["message"] == "SUCCESS") {
      ref.read(groupListProvider).changeCurrGroup(data["data"]);
      ref.read(addExpenseProvider).clearAddExpenseProvider();
      ref.read(routeProvider).changeNavbarIdx(1);
      ref.read(routeProvider).changePage("group_detail");
      await GroupServices().userGroupList(ref);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }
}
