import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/providers/group_list.dart';

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
      // userFriendList(ref);
      // friendRequestReceivedList(ref);
      // friendRequestSentList(ref);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> getGroupOwed(WidgetRef ref) async {
    final String response =
        await rootBundle.loadString('assets/groupsOwed.json');
    var data = await json.decode(response);

    ref.read(groupListProvider).loadGroupData(data["data"]);

  }

  Future<void> getGroupLent(WidgetRef ref) async {
    final String response =
        await rootBundle.loadString('assets/groupLent.json');
    var data = await json.decode(response);
    ref.read(groupListProvider).loadGroupData(data["data"]);
  }
}
