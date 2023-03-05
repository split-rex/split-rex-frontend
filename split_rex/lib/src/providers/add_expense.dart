import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/add_expense.dart';

import '../model/friends.dart';
import '../model/group_model.dart';

class AddExpenseProvider extends ChangeNotifier {
  List<Items> items = [];
  NewGroup newGroup = NewGroup();
  GroupListModel existingGroup = GroupListModel("", "", [], "", "", "", 0, 0);

  clearAddExpenseProvider() {
    items.clear();
    newGroup = NewGroup();
    existingGroup = GroupListModel("", "", [], "", "", "", 0, 0);
    notifyListeners();
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
