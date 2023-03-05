import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:split_rex/src/model/auth.dart';
import 'package:split_rex/src/model/user.dart';

class AuthProvider extends ChangeNotifier {
  SignUpModel signUpData = SignUpModel();
  SignInModel signInData = SignInModel();
  User userData = User();

  String jwtToken = "";

  void clearUserData() {
    userData = User();
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
  
  void changeJwtToken(jwt) {
    jwtToken = jwt;
  }

  void loadUserData(data) {
    userData.name = data["fullname"];
    userData.username = data["username"];
    userData.userId = data["user_id"];
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthProvider());
