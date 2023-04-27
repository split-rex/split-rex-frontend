import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/group_settings.dart';
import 'package:split_rex/src/providers/payment.dart';

import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/model/auth.dart';
import 'package:split_rex/src/model/user.dart';
import 'package:split_rex/src/providers/transaction.dart';
import 'package:split_rex/src/services/group.dart';

import '../common/const.dart';
import '../providers/activity.dart';
import '../providers/add_expense.dart';
import '../providers/friend.dart';
import '../providers/group_list.dart';
import 'activity.dart';
import 'friend.dart';

class ApiServices {
  String endpoint = getUrl();
  // String endpoint = "http:/p/localhost:8080";

  Future<void> getProfile(WidgetRef ref) async {
    Response resp =
        await get(Uri.parse("$endpoint/profile"), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${ref.watch(authProvider).jwtToken}'
    });
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(authProvider).loadUserData(data["data"]);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
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

  Future<void> updatePass(WidgetRef ref, BuildContext context) async {
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
        getProfile(ref).then((value) {
          ref.read(routeProvider).changePage(context, "/edit_account");
        });
      } else {
        ref.read(errorProvider).changeError(data["message"]);
      }
    }
  }

  bool isEmailValid(email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  Future<void> postRegister(WidgetRef ref, BuildContext context) async {
    log("postRegister");
    SignUpModel signUpData = ref.watch(authProvider).signUpData;
    if (!isEmailValid(signUpData.email)) {
      ref.read(errorProvider).changeError("ERROR_INVALID_EMAIL");
    } else if (signUpData.confPass != signUpData.pass) {
      ref
          .read(errorProvider)
          .changeError("ERROR_PASSWORD_AND_CONFIRMATION_NOT_MATCH");
    } else {
      log("postRegisterefefefe");
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
        log("SUCCESS");
        ref.read(errorProvider).changeError(data["message"]);
        ref.read(authProvider).changeJwtToken(data["data"]);
        log("fegeg");
        getProfile(ref).then((value) {
          ref.watch(activityProvider).activities.clear();
          ref.read(addExpenseProvider).resetAll();
          ref.read(friendProvider).clearFriendProvider();
          ref.read(groupListProvider).clearGroupListProvider();
          ref.read(groupSettingsProvider).resetAll();
          ref.read(paymentProvider).resetAll();
          ref.read(transactionProvider).clearTransProvider();
          EasyLoading.dismiss();
          ref.read(routeProvider).changePage(context, "/");
        });
      } else {
        EasyLoading.dismiss();
        ref.read(errorProvider).changeError(data["message"]);
      }
    }
  }

  Future<void> postLogin(WidgetRef ref, BuildContext context) async {
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
      getProfile(ref).then((value) {
        ActivityServices().getActivity(ref).then((value) {
          GroupServices().userGroupList(ref).then((value) {
            FriendServices().userFriendList(ref).then((value) {
              FriendServices().friendRequestReceivedList(ref).then((value) {
                FriendServices().friendRequestSentList(ref).then((value) {
                  ref.read(getGroupOwedLent).then((data) {
                    EasyLoading.dismiss();
                    ref.read(routeProvider).changePage(context, "/");
                  });
                });
              });
            });
          });
        });
      });
    } else {
      EasyLoading.dismiss();
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> addPaymentInfo(
    WidgetRef ref,
    BuildContext context,
    String accountName,
    int accountNumber,
  ) async {
    // meaning still default
    if (ref.watch(authProvider).newPaymentMethodData == "Payment Method") {
      ref.read(errorProvider).changeError("INVALID_PAYMENT_METHOD");
      return;
    }

    Response resp = await post(Uri.parse("$endpoint/addPaymentInfo"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ref.watch(authProvider).jwtToken}'
        },
        body: jsonEncode({
          "payment_method": ref.watch(authProvider).newPaymentMethodData,
          "account_number": accountNumber,
          "account_name": accountName,
        }));
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      await getProfile(ref);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> editPaymentInfo(
      WidgetRef ref,
      BuildContext context,
      int accountNumber,
      String accountName,
      int index) async {
    var curPinfo = ref.watch(authProvider).userData.flattenPaymentInfo[index];

    Response resp = await post(Uri.parse("$endpoint/editPaymentInfo"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ref.watch(authProvider).jwtToken}'
        },
        body: jsonEncode({
          "old_payment_method": curPinfo[0],
          "old_account_number": int.parse(curPinfo[1]),
          "old_account_name": curPinfo[2],
          "new_payment_method": curPinfo[0],
          "new_account_number": accountNumber,
          "new_account_name": accountName,
        }));
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      await getProfile(ref);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> deletePaymentInfo(
    WidgetRef ref,
    BuildContext context,
    String paymentMethod,
    int accountNumber,
    String accountName,
  ) async {
    Response resp = await post(Uri.parse("$endpoint/deletePaymentInfo"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ref.watch(authProvider).jwtToken}'
        },
        body: jsonEncode({
          "payment_method": paymentMethod,
          "account_number": accountNumber,
          "account_name": accountName,
        }));
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      getProfile(ref);
      // ignore: use_build_context_synchronously
      ref.read(routeProvider).changePage(context, "/account");
      // ignore: use_build_context_synchronously
      // Navigator.of(context).pop();
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
