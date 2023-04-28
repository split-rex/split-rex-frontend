class SpendingBuddy {
  String name;
  int color;
  int count;

  SpendingBuddy({this.name = "", this.color = 1, this.count = 0});
}

class PaymentMutation {
  double totalPaid;
  double totalReceived;
  List<Mutation> listMutation = [];

  PaymentMutation(this.totalPaid, this.totalReceived, this.listMutation);
}

class Mutation {
  String name;
  int color;
  String mutationType;
  double amount;

  Mutation(this.name, this.color, this.mutationType, this.amount);
}

class ExpenseChart {
  String month;
  double totalExpense;
  List<double> dailyExpense = [];

  ExpenseChart(this.month, this.totalExpense, this.dailyExpense);
}
