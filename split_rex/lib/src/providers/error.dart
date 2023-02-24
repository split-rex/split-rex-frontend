import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorProvider extends ChangeNotifier {
  String errorType = "";
  String errorMsg = "";

  var errorMap = <String, String>{
    "ERROR_INTERNAL_SERVER": "Server Error",
    "ERROR_BAD_REQUEST": "Please Retry",
    "ERROR_FAILED_REGISTER": "Register Failed",
    "ERROR_FAILED_LOGIN": "Login Failed",
    "ERROR_JWT_SIGNING": "JWT Error",
    "USERNAME_EXISTED": "Username Already Exists",
    "EMAIL_EXISTED": "Email Already Exists",
    "ERROR: INVALID USERNAME OR PASSWORD": "Please fill the form"
  };

  void changeError(String value) {
    errorType = value;
    errorMsg = errorMap[value].toString();
  }
}

final errorProvider = ChangeNotifierProvider((ref) => ErrorProvider());
