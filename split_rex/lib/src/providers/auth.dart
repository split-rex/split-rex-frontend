import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:split_rex/src/model/auth.dart';

class AuthProvider extends ChangeNotifier {
  SignUpModel signUpData = SignUpModel();
  SignInModel signInData = SignInModel();

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
  
}

final authProvider = ChangeNotifierProvider((ref) => AuthProvider());
