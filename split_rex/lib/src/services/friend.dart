import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/group_list.dart';

import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/model/auth.dart';

import '../providers/friend.dart';

class FriendServices {
  String endpoint = "https://split-rex-backend-7v6i6rndga-et.a.run.app";

  Future<void> userFriendList(WidgetRef ref) async {
    SignUpModel signUpData = ref.watch(authProvider).signUpData;
    if (signUpData.confPass != signUpData.pass) {
      throw Exception();
    }
    Response resp = await get(
      Uri.parse("$endpoint/userFriendList"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(friendProvider).changeUserFriendList(data["data"]);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }
}
