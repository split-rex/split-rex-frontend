import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

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
    } else if (data["message"] == "DATA_NOT_FOUND") {
      ref.read(friendProvider).friendList.clear();
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> friendRequestReceivedList(WidgetRef ref) async {
    Response resp = await get(
      Uri.parse("$endpoint/friendRequestReceived"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(friendProvider).changeUserReceivedList(data["data"]);
    } else if (data["message"] == "DATA_NOT_FOUND") {
      ref.read(friendProvider).friendReceivedList.clear();
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> friendRequestSentList(WidgetRef ref) async {
    SignUpModel signUpData = ref.watch(authProvider).signUpData;
    if (signUpData.confPass != signUpData.pass) {
      throw Exception();
    }
    Response resp = await get(
      Uri.parse("$endpoint/friendRequestSent"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(friendProvider).changeUserSentList(data["data"]);
    } else if (data["message"] == "DATA_NOT_FOUND") {
      ref.read(friendProvider).friendSentList.clear();
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  // Reject and accept friend request
  Future<void> acceptFriendRequest(WidgetRef ref, String userId) async {
    Response resp = await post(
      Uri.parse("$endpoint/acceptRequest"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
      body: jsonEncode(<String, String>{"friend_id": userId}),
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      userFriendList(ref);
      friendRequestReceivedList(ref);
      friendRequestSentList(ref);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> rejectFriendRequest(WidgetRef ref, String userId) async {
    SignUpModel signUpData = ref.watch(authProvider).signUpData;
    if (signUpData.confPass != signUpData.pass) {
      throw Exception();
    }
    Response resp = await post(
      Uri.parse("$endpoint/rejectRequest"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
      body: jsonEncode(<String, String>{"friend_id": userId}),
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      userFriendList(ref);
      friendRequestReceivedList(ref);
      friendRequestSentList(ref);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> searchUser(WidgetRef ref, String username) async {
    SignUpModel signUpData = ref.watch(authProvider).signUpData;
    if (signUpData.confPass != signUpData.pass) {
      throw Exception();
    }
    Response resp = await get(
      Uri.parse("$endpoint/searchUser?username=$username"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      userFriendList(ref);
      friendRequestReceivedList(ref);
      friendRequestSentList(ref);

      ref.read(friendProvider).changeAddFriend(data["data"]);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> searchUserToAdd(WidgetRef ref, String username) async {
    SignUpModel signUpData = ref.watch(authProvider).signUpData;
    if (signUpData.confPass != signUpData.pass) {
      throw Exception();
    }
    Response resp = await get(
      Uri.parse("$endpoint/searchUserToAdd?username=$username"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);
    var log = Logger();
    log.d(data);
    if (data["message"] == "SUCCESS") {
      ref.read(friendProvider).resetAddFriend();
      userFriendList(ref);
      friendRequestReceivedList(ref);
      friendRequestSentList(ref);

      ref.read(friendProvider).changeAddFriend(data["data"]);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
      ref.read(friendProvider).changeAddFriend(data["data"]);
    }
  }

  Future<void> addFriend(WidgetRef ref, String userId) async {
    SignUpModel signUpData = ref.watch(authProvider).signUpData;
    if (signUpData.confPass != signUpData.pass) {
      throw Exception();
    }
    Response resp = await post(
      Uri.parse("$endpoint/makeFriendRequest"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
      body: jsonEncode(<String, String>{"friend_id": userId}),
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      userFriendList(ref);
      friendRequestReceivedList(ref);
      friendRequestSentList(ref);

      // ref.read(errorProvider).errorMsg =  "ADD_FRIEND_SUCCESS";
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }
}
