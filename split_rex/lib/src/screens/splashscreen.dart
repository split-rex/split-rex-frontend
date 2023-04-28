import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_rex/src/common/header.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/services/auth.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late SharedPreferences prefs;

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    String? jwtToken = prefs.getString('jwtToken');
    if (jwtToken != "" && jwtToken != null) {
      if (JwtDecoder.isExpired(jwtToken)) {
        log("jwt not expired");
        log(jwtToken);
        ref.read(authProvider).changeJwtToken("");
        ref.read(routeProvider).changePage("sign_in");
      } else {
        ref.read(authProvider).changeJwtToken(jwtToken);
        String? email = prefs.getString('email');
        String? password = prefs.getString('password');
        ref.read(routeProvider).changePage("sign_in");
        ref.read(authProvider).changeSignInData(email, password);
        await ApiServices().postLogin(ref);
        // await signOut(ref);
      }
    } else {
      log("hewrerere");
      ref.read(routeProvider).changePage("sign_in");
    }
  }

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}
