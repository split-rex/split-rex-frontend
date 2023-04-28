import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/password.dart';

import '../common/const.dart';
import '../providers/error.dart';
import '../providers/routes.dart';

class ForgotPassServices {
  String endpoint = getUrl();

  Future<void> generatePassToken(
      WidgetRef ref, String email, BuildContext context) async {
    ref.watch(forgotPasswordProvider).changeEmail(email);
    await post(Uri.parse("$endpoint/generateResetPassToken"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
        })).then((resp) {
      var data = jsonDecode(resp.body);
      if (data["message"] == "SUCCESS") {
        ref.read(routeProvider).changePage(context, "/verify_token");
        EasyLoading.dismiss();
      } else {
        ref.read(errorProvider).changeError(data["message"]);
        EasyLoading.dismiss();
      }
    });
  }

  Future<void> verifyResetPassToken(
      WidgetRef ref, String code, BuildContext context) async {
    var email = ref.read(forgotPasswordProvider).email;
    await post(Uri.parse("$endpoint/verifyResetPassToken"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"email": email, "code": code})).then((resp) {
      var data = jsonDecode(resp.body);
      if (data["message"] == "SUCCESS") {
        ref
            .read(forgotPasswordProvider)
            .changeToken(data["data"]["encrypted_token"]);
        ref.read(forgotPasswordProvider).changeCode(code);
        ref.read(routeProvider).changePage(context, "/create_password");
        EasyLoading.dismiss();
      } else {
        ref.read(errorProvider).changeError(data["message"]);
        EasyLoading.dismiss();
      }
    });
  }

  Future<void> changePasword(BuildContext context, WidgetRef ref,
      String newPassword, String newConfPassword) async {
    if (newPassword != newConfPassword) {
      ref
          .watch(errorProvider)
          .changeError("ERROR_PASSWORD_AND_CONFIRMATION_NOT_MATCH");
      EasyLoading.dismiss();
      return;
    }
    var email = ref.watch(forgotPasswordProvider).email;
    var encryptedToken = ref.watch(forgotPasswordProvider).encryptedToken;
    var code = ref.watch(forgotPasswordProvider).code;
    await post(Uri.parse("$endpoint/changePassword"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
          "encrypted_token": encryptedToken,
          "code": code,
          "new_password": newPassword,
        })).then((Response resp) {
      var data = jsonDecode(resp.body);
      if (data["message"] == "SUCCESS") {
        EasyLoading.dismiss();
        ref.watch(routeProvider).changePage(context, "/reset_pass_success");
      } else {
        ref.watch(errorProvider).changeError("ERROR_FAILED_PASS_CHANGE");
        EasyLoading.dismiss();
      }
    });
  }
}
