import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/add_expense.dart';

import '../model/friends.dart';
import '../model/group_model.dart';

class AddExpenseProvider extends ChangeNotifier {
  List<Items> items = [];
  bool isNewGroup = false;
  NewGroup newGroup = NewGroup();
  Transaction newBill = Transaction();
  GroupListModel existingGroup = GroupListModel("", "", [], "", "", "", 0, 0);

  clearAddExpenseProvider() {
    items.clear();
    isNewGroup = false;
    newGroup = NewGroup();
    existingGroup = GroupListModel("", "", [], "", "", "", 0, 0);
    notifyListeners();
  }

  resetNewGroup() {
    newGroup.name = "";
    newGroup.startDate = "";
    newGroup.endDate = "";
  }

  changeBillName(val) {
    newBill.name = val;
  }

  addItem() {
    items.add(Items());
    notifyListeners();
  }

  changeItemName(index, String val) {
    items[index].name = val;
  }

  changeItemQty(index, int val) {
    items[index].qty = val;
  }

  changeItemPrice(index, int val) {
    items[index].price = val;
  }

  changeItemSelected(index) {
    items[index].selected = !items[index].selected;
    notifyListeners();
  }

  changeSelectedGroup(GroupListModel group) {
    if (existingGroup.groupId == group.groupId) {
      existingGroup = GroupListModel("", "", [], "", "", "", 0, 0);
    } else {
      existingGroup = group;
    }
    notifyListeners();
  }

  changeSelectedFriends(Friend member) {
    if (newGroup.memberId.contains(member.userId)) {
      newGroup.memberId.remove(member.userId);
    } else {
      newGroup.memberId.add(member.userId);
    }

    if (newGroup.memberId.isEmpty) {
      isNewGroup = false;
    } else {
      isNewGroup = true;
    }

    notifyListeners();
  }

  changeNewGroupName(val) {
    newGroup.name = val;
    notifyListeners();
  }

  changeNewGroupStartDate(val) {
    newGroup.startDate = val;
    notifyListeners();
  }

  changeNewGroupEndDate(val) {
    newGroup.endDate = val;
    notifyListeners();
  }
}

final addExpenseProvider = ChangeNotifierProvider((ref) => AddExpenseProvider());
