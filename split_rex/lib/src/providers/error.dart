import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorProvider extends ChangeNotifier {
  String errorType = "";
  String errorMsg = "";

  Map<String, String> errorMap = {
    "ERROR_EMPTY_NAME": "Please fill in name",
    "ERROR_EMPTY_USERNAME": "Please fill in username",
    "ERROR_EMPTY_EMAIL": "Please fill in email",
    "ERROR_EMPTY_PASS": "Please fill in password",
    "ERROR_INTERNAL_SERVER": "Server Error",
    "ERROR_BAD_REQUEST": "Please Retry",
    "ERROR_FAILED_REGISTER": "Register Failed",
    "ERROR_FAILED_LOGIN": "Login Failed",
    "ERROR_JWT_SIGNING": "JWT Error",
    "ERROR_USERNAME_EXISTED": "Username Already Exists",
    "ERROR_INVALID_EMAIL": "Please Use Valid Email Address",
    "ERROR_EMAIL_EXISTED": "Email Already Exists",
    "ERROR: INVALID USERNAME OR PASSWORD": "Please fill the form",
    "ERROR_CANNOT_ADD_SELF": "You cannot add yourself",
    "ERROR_ALREADY_FRIEND": "User is already friend",
    "ERROR_USER_NOT_FOUND": "User not found",
    "ERROR_PASSWORD_AND_CONFIRMATION_NOT_MATCH":
        "Your password and confirmation does not match!",
    "ERROR_ALREADY_REQUESTED_SENT": "Friend request sent",
    "ERROR_ALREADY_REQUESTED_RECEIVED":
        "This user has sent friend request to you",
    "INVALID_PAYMENT_METHOD": "Change payment method",
    "ERROR_FAILED_PASS_CHANGE": "Failed to change password",
    "ERROR_TOKEN": "Token is wrong"    
  };

  void changeError(String value) {
    errorType = value;
    errorMsg = errorMap[value].toString();

    notifyListeners();
  }
}

final errorProvider = ChangeNotifierProvider((ref) => ErrorProvider());
