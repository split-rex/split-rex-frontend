import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouteProvider extends ChangeNotifier {
  int currentNavbarIdx = 0;

  void clearRouteProvider() {
    currentNavbarIdx = 0;
    notifyListeners();
  }

  void changePage(context, value) {
    if (
      (value == "/sign_in")
      ||
      (ModalRoute.of(context)?.settings.name == "/account" && value == "/sign_in")
      ||
      (
      (ModalRoute.of(context)?.settings.name == "/"
      || ModalRoute.of(context)?.settings.name == "/sign_up"
      || ModalRoute.of(context)?.settings.name == "/sign_in") 
      && value == "/home")
    ) {
      Navigator.pushNamedAndRemoveUntil(
        context, 
        value, 
        (Route<dynamic> route) => false,
        arguments: ModalRoute.of(context)?.settings.name
      );
    } else if (ModalRoute.of(context)?.settings.name == "/scan_bill") {
      if (value == "/home") {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacementNamed(context, value, arguments: ModalRoute.of(context)?.settings.name);
      }
    } else {
      Navigator.pushNamed(context, value, arguments: ModalRoute.of(context)?.settings.name);
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
