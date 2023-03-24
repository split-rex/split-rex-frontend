import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:split_rex/src/model/auth.dart';
import 'package:split_rex/src/model/user.dart';

class AuthProvider extends ChangeNotifier {
  SignUpModel signUpData = SignUpModel();
  SignInModel signInData = SignInModel();
  UserUpdate newUserData = UserUpdate();
  User userData = User();

  String jwtToken = "";
  bool isVisible = true;

  void clearAuthProvider() {
    signUpData = SignUpModel();
    signInData = SignInModel();
    userData = User();
    jwtToken = "";
    notifyListeners();
  }

  void changeSignUpData(name, username, email, pass, confPass){
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
  }

  void changeUserName(name) {
    newUserData.name = name;
  }

  void changeUserPass(pass) {
    newUserData.password = pass;
  }

  void changeUserConfPass(confPass) {
    newUserData.confPassword = confPass;
  }

  void resetNewUserData() {
    newUserData = UserUpdate();
    newUserData.color = userData.color;
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
    // userData.email = data["email"];
    userData.color = data["color"];
    newUserData.color = data["color"];
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthProvider());
