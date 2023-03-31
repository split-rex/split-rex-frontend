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

  GroupListModel(this.groupId, this.name, this.members, this.startDate,
      this.endDate, this.type, this.totalUnpaid, this.totalExpense);
}


