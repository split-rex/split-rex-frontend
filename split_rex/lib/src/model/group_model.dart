import 'package:split_rex/src/model/add_expense.dart';

class GroupListModel {
  String groupId;
  String name;
  List<dynamic> members;
  String startDate;
  String endDate;
  String type;
  int totalUnpaid;
  int totalExpense;
  List<Transaction> transactions = [];
  List<GroupActivity> groupActivities = [];

  GroupListModel(this.groupId, this.name, this.members, this.startDate,
      this.endDate, this.type, this.totalUnpaid, this.totalExpense);
}

class GroupActivity {
  String activityId;
  String date;
  String name1;
  String name2;
  int amount;

  GroupActivity(this.activityId, this.date, this.name1, this.name2,
      this.amount);
}
