import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouteProvider extends ChangeNotifier {
  String currentPage = "sign_up";
  int currentNavbarIdx = 0;
  bool isNavbarRevealed = false;

  void clearRouteProvider() {
    currentPage = "sign_up";
    currentNavbarIdx = 0;
    isNavbarRevealed = false;
    notifyListeners();
  }

  final List<String> _pagesWithNavbar = [
    "home",
    "activity",
    "group_list",
    "account",
  ];

  void changePage(value) {
    currentPage = value;
    if (_pagesWithNavbar.contains(value)) {
      isNavbarRevealed = true;
    } else {
      isNavbarRevealed = false;
    }
    notifyListeners();
  }

  void changeNavbarIdx(value) {
    currentNavbarIdx = value;
    switch (value) {
      case 0:
        changePage("home");
        break;
      case 1:
        changePage("group_list");
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
