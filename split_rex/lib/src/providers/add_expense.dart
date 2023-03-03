import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/add_expense.dart';

class AddExpenseProvider extends ChangeNotifier {
  List<String> groups = <String>['Singapore Trip', 'GKUB', 'Anjay geming'];
  List<String> itemsName = ["Ayam", "Bebek Aji Anom"];
  List<int> itemsQty = [1, 2];
  List<int> itemsPrice = [50000, 70000];

  bool checkedFriends = false;
  bool checkedGroups = false;
  List<int> selectedFriendsIdx = [];
  int selectedGroupIdx = -1;

  NewGroup newGroup = NewGroup();

  clearExpense() {
    itemsName.clear();
    itemsQty.clear();
    itemsPrice.clear();
    checkedFriends = false;
    checkedGroups = false;
    selectedFriendsIdx.clear();
    selectedGroupIdx = -1;
    newGroup = NewGroup();
    notifyListeners();
  }

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

  changeBillName(val) {
    newGroup.name = val;
    notifyListeners();
  }

  changeStartDate(val) {
    newGroup.startDate = val;
    notifyListeners();
  }

  changeEndDate(val) {
    newGroup.endDate = val;
    notifyListeners();
  }
}

final addExpenseProvider = ChangeNotifierProvider((ref) => AddExpenseProvider());
