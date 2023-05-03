import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/logger.dart';
import 'package:split_rex/src/model/statistics.dart';

class StatisticsProvider extends ChangeNotifier {
  String startSettleDate = '';
  String endSettleDate = '';
  String startUnsettledDate = '';
  String endUnsettledDate = '';
  int totalOwed = 0;
  int totalLent = 0;
  int owedPercentage = 0;
  int lentPercentage = 0;
  List<SpendingBuddy> spendingBuddies = [];
  PaymentMutation paymentMutation = PaymentMutation(0, 0, []);
  ExpenseChart expenseChart = ExpenseChart("", 0, []);

  bool showUnsettled = false;
  bool showSettled = false;

  void clearStatisticsProvider(){
    startSettleDate = '';
    endSettleDate = '';
    startUnsettledDate = '';
    endUnsettledDate = '';
    owedPercentage = 0;
    lentPercentage = 0;
    spendingBuddies = [];
    paymentMutation = PaymentMutation(0, 0, []);
    expenseChart = ExpenseChart("", 0, []);

    showUnsettled = false;
    showSettled = false;
    notifyListeners();
  }

  void loadSpendingBuddies(dynamic spendingBuddiesSource) {
    logger.d(spendingBuddiesSource);
    spendingBuddies.clear();

    SpendingBuddy buddy1 = SpendingBuddy();
    SpendingBuddy buddy2 = SpendingBuddy();
    SpendingBuddy buddy3 = SpendingBuddy();

    buddy1.name = spendingBuddiesSource["buddy1"]["name"];
    buddy2.name = spendingBuddiesSource['buddy2']["name"];
    buddy3.name = spendingBuddiesSource['buddy3']["name"];

    buddy1.color = spendingBuddiesSource['buddy1']["color"];
    buddy2.color = spendingBuddiesSource['buddy2']["color"];
    buddy3.color = spendingBuddiesSource['buddy3']["color"];

    buddy1.count = spendingBuddiesSource['buddy1']["count"];
    buddy2.count = spendingBuddiesSource['buddy2']["count"];
    buddy3.count = spendingBuddiesSource['buddy3']["count"];

    spendingBuddies.add(buddy1);
    spendingBuddies.add(buddy2);
    spendingBuddies.add(buddy3);

    notifyListeners();
  }

  void loadPaymentMutation(dynamic paymentMutationSource) {
    paymentMutation = PaymentMutation(0, 0, []);

    paymentMutation.totalPaid = paymentMutationSource['total_paid'].toDouble();
    paymentMutation.totalReceived =
        paymentMutationSource['total_received'].toDouble();
    for (int i = 0; i < paymentMutationSource['list_mutation'].length; i++) {
      Mutation mutation = Mutation("", 0, "", 0.0);

      mutation.name = paymentMutationSource['list_mutation'][i]['name'];
      mutation.color = paymentMutationSource['list_mutation'][i]['color'];
      mutation.mutationType =
          paymentMutationSource['list_mutation'][i]['mutation_type'];
      mutation.amount =
          paymentMutationSource['list_mutation'][i]['amount'].toDouble();

      paymentMutation.listMutation.add(mutation);
    }
  }

  void loadExpenseChart(dynamic expenseChartSource) {
    expenseChart = ExpenseChart("", 0.0, []);

    expenseChart.month = expenseChartSource['month'];
    expenseChart.totalExpense = expenseChartSource['total_expense'].toDouble();
    for (int i = 0; i < expenseChartSource['daily_expense'].length; i++) {
      expenseChart.dailyExpense
          .add(expenseChartSource['daily_expense'][i].toDouble());
    }
  }

  void loadPercentageData(dynamic percentageData) {
    logger.d(percentageData);
    owedPercentage = percentageData['owed_percentage'];
    lentPercentage = percentageData['lent_percentage'];
    totalOwed = percentageData["total_owed"];
    totalLent = percentageData["total_lent"];
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
