import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    await SharedPreferences.getInstance().then((prefs) {
      String? jwtToken = prefs.getString('jwtToken');
      if (jwtToken != "" && jwtToken != null) {
        if (JwtDecoder.isExpired(jwtToken)) {
          log(jwtToken);
          ref.read(authProvider).changeJwtToken("");
          ref.read(routeProvider).changePage(context, "/sign_in");
        } else {
          ref.read(authProvider).changeJwtToken(jwtToken);
          String? email = prefs.getString('email');
          String? password = prefs.getString('password');
          ref.read(authProvider).changeSignInData(email, password);
          ApiServices().postLogin(ref, context);
        }
      } else {
        log("hewrerere");
        ref.read(routeProvider).changePage(context, "/sign_in");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment : MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/logo_splitrex_full.png",
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
        ])
      )
    );
  }
}
