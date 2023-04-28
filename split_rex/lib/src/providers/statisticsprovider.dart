import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatisticsProvider extends ChangeNotifier {
  String startSettleDate = '';
  String endSettleDate = '';
  String startUnsettledDate = '';
  String endUnsettledDate = '';
  int owedPercentage = 0;
  int lentPercentage = 0;

  bool showUnsettled = false;
  bool showSettled = false;

  void loadPercentageData(dynamic percentageData) {

    owedPercentage = percentageData['owed_percentage'];
    lentPercentage = percentageData['lent_percentage'];
    notifyListeners();
  }

  void changeShowUnsettled(bool val) {
    showUnsettled = val;
    notifyListeners();
  }

  void changeShowSettled(bool val) {
    showSettled = val;
    notifyListeners();
  }

  void changeStartSettleDate(String date) {
    startSettleDate = date;
    notifyListeners();
  }

  void changeEndSettleDate(String date) {
    endSettleDate = date;
    notifyListeners();
  }

  void changeStartUnsettledDate(String date) {
    startUnsettledDate = date;
    notifyListeners();
  }

  void changeEndUnsettledDate(String date) {
    endUnsettledDate = date;
    notifyListeners();
  }
}

final statisticsProvider =
    ChangeNotifierProvider((ref) => StatisticsProvider());
