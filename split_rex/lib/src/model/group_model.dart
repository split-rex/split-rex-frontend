class GroupListModel {
  String groupId;
  String name;
  List<dynamic> members;
  String startDate;
  String endDate;
  String type;
  int totalUnpaid;
  int totalExpense;

  GroupListModel(this.groupId, this.name, this.members, this.startDate,
      this.endDate, this.type, this.totalUnpaid, this.totalExpense);
}


