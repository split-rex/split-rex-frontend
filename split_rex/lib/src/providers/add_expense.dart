import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpenseProvider extends ChangeNotifier {
  List<String> groups = <String>['Singapore Trip', 'GKUB', 'Anjay geming'];
  List<String> friends = <String>['Gres Klaudia', 'Eppy', 'Kwen XOTK', 'Petoriko', 'Sam well', 'Nan dough', 'Ubye'];
  List<String> itemsName = ["Ayam", "Bebek Aji Anom"];
  List<int> itemsQty = [1, 2];
  List<int> itemsPrice = [50000, 70000];
  bool checkedFriends = false;
  bool checkedGroups = false;

  List<int> selectedFriendsIdx = [];
  int selectedGroupIdx = -1;

  addItemName(index, String val) {
    itemsName.insert(index, val);
  }

  addItemQty(index, int val) {
    itemsQty.insert(index, val);
  }

  addItemPrice(index, int val) {
    itemsPrice.insert(index, val);
  }

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
