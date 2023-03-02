// contoh


class GroupListModel {
  String groupId;
  String name;
  List<dynamic> memberId;
  String startDate;
  String endDate;
  String type;
  int totalUnpaid;
  int totalExpense;

  GroupListModel(this.groupId, this.name, this.memberId, this.startDate,
      this.endDate, this.type, this.totalUnpaid, this.totalExpense);
}


