import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/model/auth.dart';
import 'package:split_rex/src/model/user.dart';
import 'package:split_rex/src/services/group.dart';

import 'friend.dart';

class ApiServices {
  String endpoint = "https://split-rex-backend-7v6i6rndga-et.a.run.app";

  Future<void> getProfile(WidgetRef ref) async {
    Response resp =
        await get(Uri.parse("$endpoint/profile"), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${ref.watch(authProvider).jwtToken}'
    });
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(authProvider).loadUserData(data["data"]);
      ref.read(errorProvider).changeError(data["message"]);

      var logger = Logger();

      logger.d(ref.watch(authProvider).userData.name);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
      var logger = Logger();
      logger.d(data);
    }
  }

  Future<void> updateProfile(WidgetRef ref) async {
    UserUpdate newUserData = ref.watch(authProvider).newUserData;
    Response resp = await post(Uri.parse("$endpoint/updateProfile"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ref.watch(authProvider).jwtToken}'
      },
      body: jsonEncode({
        "name": newUserData.name,
        "color": newUserData.color,
      }));
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(authProvider).resetNewUserData();
      await getProfile(ref);
    } else {
        ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> updatePass(WidgetRef ref) async {
    UserUpdatePass newPass = ref.watch(authProvider).newPass;
    if (newPass.confNewPass != newPass.newPass) {
      ref
        .read(errorProvider)
        .changeError("ERROR_PASSWORD_AND_CONFIRMATION_NOT_MATCH");
    } else {
      Response resp = await post(Uri.parse("$endpoint/updatePassword"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ref.watch(authProvider).jwtToken}'
        },
        body: jsonEncode({
          "old_password": newPass.oldPass,
          "new_password": newPass.newPass,
        }));
      var data = jsonDecode(resp.body);
      if (data["message"] == "SUCCESS") {
        ref.read(authProvider).resetNewPass();
        await getProfile(ref);
        ref.watch(routeProvider).changePage("edit_account");
      } else {
          ref.read(errorProvider).changeError(data["message"]);
      }
    }
  }

  bool isEmailValid(email) {
      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  Future<void> postRegister(WidgetRef ref) async {
    SignUpModel signUpData = ref.watch(authProvider).signUpData;
    if (!isEmailValid(signUpData.email)) {
      ref
          .read(errorProvider)
          .changeError("ERROR_INVALID_EMAIL");
    }
    else if (signUpData.confPass != signUpData.pass) {
      ref
          .read(errorProvider)
          .changeError("ERROR_PASSWORD_AND_CONFIRMATION_NOT_MATCH");
    } else {
      Response resp = await post(Uri.parse("$endpoint/register"),
          headers: <String, String>{'Content-Type': 'application/json'},
          body: jsonEncode(<String, String>{
            "name": signUpData.name,
            "email": signUpData.email,
            "username": signUpData.username,
            "password": signUpData.pass
          }));
      var data = jsonDecode(resp.body);
      if (data["message"] == "SUCCESS") {
        ref.read(errorProvider).changeError(data["message"]);
        ref.read(authProvider).changeJwtToken(data["data"]);
        await getProfile(ref);
        await FriendServices().userFriendList(ref);
        await FriendServices().friendRequestReceivedList(ref);
        await FriendServices().friendRequestSentList(ref);
        ref.read(routeProvider).changePage("home");
      } else {
        // print(data["message"]);
        ref.read(errorProvider).changeError(data["message"]);
        // print(ref.watch(errorProvider).errorType);
      }
    }
  }

  Future<void> postLogin(WidgetRef ref) async {
    SignInModel signInData = ref.watch(authProvider).signInData;
    Response resp = await post(Uri.parse("$endpoint/login"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          "email": signInData.email,
          "password": signInData.pass
        }));
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(authProvider).changeJwtToken(data["data"]);
      ref.read(errorProvider).changeError(data["message"]);
      await getProfile(ref);
      await FriendServices().userFriendList(ref);
      await FriendServices().friendRequestReceivedList(ref);
      await FriendServices().friendRequestSentList(ref);
      await GroupServices().getGroupOwed(ref);
      await GroupServices().userGroupList(ref);
      ref.read(routeProvider).changePage("home");
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  // Future<void> readJson(WidgetRef ref) async {
  //   // final String response = await rootBundle.loadString('assets/groups.json');

  //   var data = await json.decode(response);
  //   ref.read(groupListProvider).loadGroupData(data["data"]);
  //   // setState(() {
  //   //   _items = data["items"];
  //   //   print("..number of items ${_items.length}");
  //   // });
  // }
}
