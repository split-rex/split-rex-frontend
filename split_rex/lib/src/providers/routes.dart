import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/screens/auth/sign_up.dart';
import 'package:split_rex/src/screens/home.dart';

import '../common/logger.dart';

class RouteProvider extends ChangeNotifier {
  int currentNavbarIdx = 0;

  void clearRouteProvider() {
    currentNavbarIdx = 0;
    notifyListeners();
  }

  void changePage(context, value) {
    if (ModalRoute.of(context)?.settings.name == "/account" && value == "/sign_up") {
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(
          builder: (context) => const SignUpScreen()
        ), 
        ModalRoute.withName("/sign_up")
      );
    } else if (
      (ModalRoute.of(context)?.settings.name == "/"
      || ModalRoute.of(context)?.settings.name == "/sign_up"
      || ModalRoute.of(context)?.settings.name == "/sign_in") 
      && value == "/home") {
        Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(
          builder: (context) => const Home()
        ), 
        ModalRoute.withName("/home")
      );
    } else if (ModalRoute.of(context)?.settings.name == "/scan_bill") {
      if (value == "/home") {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacementNamed(context, value);
      }
    } else {
      Navigator.pushNamed(context, value);
    }
    notifyListeners();
  }

  void changeNavbarIdx(context, value) {
    currentNavbarIdx = value;
    switch (value) {
      case 0:
        changePage(context, "/home");
        break;
      case 1:
        changePage(context, "/group_list");
        break;
      case 3:
        changePage(context, "/activity");
        break;
      case 4:
        changePage(context, "/account");
        break;
    }
    notifyListeners();
  }
}

final routeProvider = ChangeNotifierProvider((ref) => RouteProvider());
