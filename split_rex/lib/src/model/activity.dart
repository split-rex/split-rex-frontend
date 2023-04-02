import 'package:split_rex/src/model/add_expense.dart';

class ActivityModel {
  String activityId;
  String activityType;
  String date;
  String redirectId; 
  String? paymentActivityId;
  String? name;
  String? status;
  int? amount;
  String? groupName;
  String? transactionActivityId;

  ActivityModel(
      {required this.activityId,
      required this.activityType,
      required this.date,
      required this.redirectId,
      this.paymentActivityId,
      this.name,
      this.status,
      this.amount,
      this.groupName,
      this.transactionActivityId});

  // factory ActivityData.fromJson(Map<String, dynamic> json) {
  //   return ActivityData(
  //     activityId: json['activity_id'],
  //     activityType: json['activity_type'],
  //     date: json['date'],
  //     redirectId: json['redirect_id'],
  //     detail: Detail.fromJson(json['detail']),
  //   );
  // }
}


// class Detail {
//   final String paymentActivityId;
//   final String? name;
//   final String? status;
//   final int? amount;
//   final String? groupName;
//   final String? transactionActivityId;

//   Detail(
//       {required this.paymentActivityId,
//       this.name,
//       this.status,
//       this.amount,
//       this.groupName,
//       this.transactionActivityId});

//   // factory Detail.fromJson(Map<String, dynamic> json) {
//   //   return Detail(
//   //     paymentActivityId: json['payment_activity_id'] ?? "",
//   //     name: json['name'],
//   //     status: json['status'],
//   //     amount: json['amount'],
//   //     groupName: json['group_name'],
//   //     transactionActivityId: json['transaction_activity_id'],
//   //   );
//   // }
// }