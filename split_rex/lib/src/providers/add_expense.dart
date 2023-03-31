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

  String selectedMember = "";

  resetAll() {
    items = [];
    isNewGroup = false;
    newGroup = NewGroup();
    newBill = Transaction();
    existingGroup = GroupListModel("", "", [], "", "", "", 0, 0);
    selectedMember = "";
    notifyListeners();
  }

  changeSelectedMember(val) {
    selectedMember = val;
    notifyListeners();
  }

  resetNewGroup() {
    newGroup.name = "";
    newGroup.startDate = "";
    newGroup.endDate = "";
  }

  changeBillName(val) {
    newBill.name = val;
    notifyListeners();
  }

  changeBillDate(val) {
    newBill.date = val;
    notifyListeners();
  }

  convertStringToInt(str) {
    int val;
    if (str == "") {
      val = 0;
    } else {
      val = int.parse(str);
    }
    return val;
  }
  
  changeBillTax(String str) {
    int val = convertStringToInt(str);
    newBill.total -= newBill.tax;
    newBill.tax = val;
    newBill.total += val;
    notifyListeners();
  }

  changeBillService(String str) {
    int val = convertStringToInt(str);
    newBill.total -= newBill.service;
    newBill.service = val;
    newBill.total += val;
    notifyListeners();
  }

  addBillSubtotalTotal(int val) {
    newBill.total += val;
    newBill.subtotal += val;
    notifyListeners();
  }

  changeBillTotal(int val) {
    newBill.total = val;
    notifyListeners();
  }

  addEmptyItem() {
    items.add(Items());
    notifyListeners();
  }

  addItem(Items item) {
    items.add(item);
    notifyListeners();
  }

  deleteItem(index) {
    newBill.subtotal -= items[index].total;
    newBill.total -= items[index].total;
    items.removeAt(index);
    notifyListeners();
  }

  changeItemName(index, String val) {
    items[index].name = val;
  }

  changeItemQty(index, String str) {
    int val = convertStringToInt(str);
    items[index].qty = val;
    newBill.total -= newBill.subtotal;
    newBill.subtotal -= items[index].total;
    items[index].total = items[index].price * items[index].qty;
    newBill.subtotal += items[index].total;
    newBill.total += newBill.subtotal;
    notifyListeners();
  }

  changeItemPrice(index, String str) {
    int val = convertStringToInt(str);
    items[index].price = val;
    newBill.total -= newBill.subtotal;
    newBill.subtotal -= items[index].total;
    items[index].total = items[index].price * items[index].qty;
    newBill.subtotal += items[index].total;
    newBill.total += newBill.subtotal;
    notifyListeners();
  }
  
  changeItemConsumer(index, userId) {
    if (items[index].consumer.contains(userId)) {
      items[index].consumer.remove(userId);
    } else {
      items[index].consumer.add(userId);
    }
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
