import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/password.dart';

import '../common/const.dart';
import '../providers/error.dart';
import '../providers/routes.dart';

class ForgotPassServices {
  String endpoint = getUrl();

  Future<void> generatePassToken(WidgetRef ref, String email) async {
    Response resp = await post(Uri.parse("$endpoint/generateResetPassToken"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
        }));
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      EasyLoading.dismiss();
    } else {
      ref.read(errorProvider).changeError(data["message"]);
      EasyLoading.dismiss();
    }
  }

  Future<void> verifyResetPassToken(WidgetRef ref, String code) async {
    var email = ref.read(forgotPasswordProvider).email;
    Response resp = await post(Uri.parse("$endpoint/verifyResetPassToken"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"email": email, "code": code}));
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref
          .read(forgotPasswordProvider)
          .changeToken(data["data"]["encrypted_token"]);
      ref.read(forgotPasswordProvider).changeCode(code);
      EasyLoading.dismiss();
    } else {
      ref.read(errorProvider).changeError(data["message"]);
      EasyLoading.dismiss();
    }
  }

  Future<void> changePasword(
      WidgetRef ref, String newPassword, String newConfPassword) async {
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
    Response resp = await post(Uri.parse("$endpoint/changePassword"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
          "encrypted_token": encryptedToken,
          "code": code,
          "new_password": newPassword,
        }));
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.watch(routeProvider).changePage("reset_pass_success");
      EasyLoading.dismiss();
    } else {
      ref.watch(errorProvider).changeError("ERROR_FAILED_PASS_CHANGE");
      EasyLoading.dismiss();
    }
  }
}
