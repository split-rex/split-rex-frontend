import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpenseProvider extends ChangeNotifier {
  List<String> groups = <String>['Singapore Trip', 'GKUB', 'Anjay geming'];
  List<String> friends = <String>['Gres Klaudia', 'Eppy', 'Kwen XOTK', 'Petoriko', 'Sam well', 'Nan dough', 'Ubye'];
  bool checkedFriends = false;
  bool checkedGroups = false;

  List<int> selectedFriendsIdx = [];
  int selectedGroupIdx = -1;

  changeSelectedGroup(val) {
    if (val == selectedGroupIdx) {
      selectedGroupIdx = -1;
    } else {
      selectedGroupIdx = val;
    }
    checkedGroups = !checkedGroups;
    notifyListeners();
  }

  changeSelectedFriends(val) {
    if (selectedFriendsIdx.contains(val)) {
      selectedFriendsIdx.remove(val);
    } else {
      selectedFriendsIdx.add(val);
    }
    checkedFriends = selectedFriendsIdx.isEmpty ? false : true;
    notifyListeners();
  }
}

final addExpenseProvider = ChangeNotifierProvider((ref) => AddExpenseProvider());
