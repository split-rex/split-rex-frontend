import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/password.dart';

import '../common/const.dart';
import '../common/logger.dart';
import '../providers/error.dart';

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
      logger.d(data);
      // var token = data["data"]["token"];
      // var seal = data["data"]["encrypted_token"];
      // ref.read(forgotPasswordProvider).changeToken(token, seal);

      EasyLoading.dismiss();
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> verifyResetPassToken(
      WidgetRef ref, String email, String code) async {
    Response resp = await post(Uri.parse("$endpoint/verifyResetPassToken"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"email": email, "encypted_token": "", "code": code}));
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
    } else {}
  }

  Future<void> changePasword(
      WidgetRef ref, String email, String code, String newPassword) async {
    Response resp = await post(Uri.parse("$endpoint/changePassword"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
          "encypted_token": "",
          "code": code,
          "new_password": newPassword,
        }));
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
    } else {}
  }
}
