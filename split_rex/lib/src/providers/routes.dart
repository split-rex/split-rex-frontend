import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouteProvider extends ChangeNotifier {
  String currentPage = "sign_up";
  int currentNavbarIdx = 0;
  bool isLogged = false;

  void changePage(value){
    currentPage = value;
    notifyListeners();
  }

  void changeLogged() {
    isLogged = !isLogged;
    notifyListeners();
  }

  void changeNavbarIdx(value) {
    currentNavbarIdx = value;
    switch(value) {
      case 0:
        changePage("home");
        break;
      case 1:
        changePage("group");
        break;
      case 3:
        changePage("activity");
        break;
      case 4:
        changePage("account");
        break;
    }
    notifyListeners();
  }
}

final routeProvider = ChangeNotifierProvider((ref) => RouteProvider());
