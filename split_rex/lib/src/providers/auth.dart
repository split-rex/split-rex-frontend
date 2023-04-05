import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:split_rex/src/model/auth.dart';
import 'package:split_rex/src/model/user.dart';

class AuthProvider extends ChangeNotifier {
  SignUpModel signUpData = SignUpModel();
  SignInModel signInData = SignInModel();
  UserUpdate newUserData = UserUpdate();
  UserUpdatePass newPass = UserUpdatePass();
  User userData = User();
  String newPaymentMethodData = "Payment Method";

  String jwtToken = "";
  bool isVisible = true;

  void clearAuthProvider() {
    signUpData = SignUpModel();
    signInData = SignInModel();
    userData = User();
    jwtToken = "";
    notifyListeners();
  }

  void changeSignUpData(name, username, email, pass, confPass) {
    signUpData.name = name;
    signUpData.username = username;
    signUpData.email = email;
    signUpData.pass = pass;
    signUpData.confPass = confPass;
  }

  void changeSignInData(email, pass) {
    signInData.email = email;
    signInData.pass = pass;
  }

  void changeUserColor(color) {
    newUserData.color = color;
    notifyListeners();
  }

  void changeUserName(name) {
    newUserData.name = name;
  }

  void changeOldPass(pass) {
    newPass.oldPass = pass;
  }

  void changeNewPass(pass) {
    newPass.newPass = pass;
  }

  void changeConfNewPass(pass) {
    newPass.confNewPass = pass;
  }

  void changePaymentMethod(data) {
    newPaymentMethodData = data;
    notifyListeners();
  }

  void changePaymentMethodNonListeners(data) {
    newPaymentMethodData = data;
  }

  void resetNewPass() {
    newPass.oldPass = "";
    newPass.newPass = "";
    newPass.confNewPass = "";
  }

  void resetNewUserData() {
    newUserData.name = userData.name;
    newUserData.color = userData.color;
  }

  void resetColor() {
    newUserData.color = userData.color;
  }

  void resetPaymentMethod() {
    newPaymentMethodData = "Payment Method";
    notifyListeners();
  }

  void changeVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void changeJwtToken(jwt) {
    jwtToken = jwt;
  }

  void loadUserData(data) {
    userData.name = data["fullname"];
    userData.username = data["username"];
    userData.userId = data["user_id"];
    userData.email = data["email"];
    userData.color = data["color"];

    userData.paymentInfo = {};
    userData.flattenPaymentInfo = [];
    var paymentInfo = data["payment_info"];
    for (var paymentMethod in paymentInfo.keys) {
      Map<int, String> listOfAcc = <int, String>{};
      for (var accountNumber in paymentInfo[paymentMethod].keys) {
        var accountName = paymentInfo[paymentMethod][accountNumber];
        listOfAcc[int.parse(accountNumber)] = accountName;

        userData.flattenPaymentInfo.add([
          paymentMethod,
          accountNumber,
          accountName,
        ]);
      }
      userData.paymentInfo[paymentMethod] = listOfAcc;
    }

    newUserData.color = data["color"];
    notifyListeners();
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthProvider());
