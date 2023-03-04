import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorProvider extends ChangeNotifier {
  String errorType = "";
  String errorMsg = "";

  Map<String, String> errorMap = {
    "ERROR_INTERNAL_SERVER": "Server Error",
    "ERROR_BAD_REQUEST": "Please Retry",
    "ERROR_FAILED_REGISTER": "Register Failed",
    "ERROR_FAILED_LOGIN": "Login Failed",
    "ERROR_JWT_SIGNING": "JWT Error",
    "USERNAME_EXISTED": "Username Already Exists",
    "EMAIL_EXISTED": "Email Already Exists",
    "ERROR: INVALID USERNAME OR PASSWORD": "Please fill the form",
    "ERROR_CANNOT_ADD_SELF": "You cannot add yourself",
    "ERROR_ALREADY_FRIEND": "User is already friend",
    "ERROR_USER_NOT_FOUND": "User not found"
  };

  void changeError(String value) {
    errorType = value;
    errorMsg = errorMap[value].toString();

    notifyListeners();
  }
}

final errorProvider = ChangeNotifierProvider((ref) => ErrorProvider());
