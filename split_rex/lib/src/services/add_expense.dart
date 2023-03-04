import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/add_expense.dart';

import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';

import '../common/logger.dart';
import '../model/friends.dart';
import '../providers/friend.dart';
import '../providers/add_expense.dart';

class FriendServices {
  String endpoint = "https://split-rex-backend-7v6i6rndga-et.a.run.app";

  Future<void> createGroup(WidgetRef ref) async {
    List<Friend> friendsList = ref.watch(friendProvider).friendList;
    List<int> friendsIndex = ref.watch(addExpenseProvider).selectedFriendsIdx;

    NewGroup newGroup = ref.watch(addExpenseProvider).newGroup;
    for (int index in friendsIndex) {
      newGroup.memberId.add(friendsList[index].userId);
    }

    Response resp = await post(Uri.parse("$endpoint/userCreateGroup"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
        },
        body: jsonEncode(<String, dynamic>{
          "name": newGroup.name,
          "member_id": newGroup.memberId,
          "start_date": newGroup.startDate,
          "end_date": newGroup.endDate
        }));
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      logger.d("yuyu");
      ref.read(addExpenseProvider).clearExpense();
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }
}
