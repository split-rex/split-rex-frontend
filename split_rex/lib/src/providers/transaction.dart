import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/add_expense.dart';

class TransactionProvider extends ChangeNotifier {
  Transaction currTrans = Transaction();

  void changeTrans(Transaction trans) {
    currTrans = trans;
    notifyListeners();
  }

  void clearTransProvider() {
    currTrans = Transaction();
    notifyListeners();
  }
}

final transactionProvider = ChangeNotifierProvider((ref) => TransactionProvider());
