import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/activity.dart';

class ActivityProvider extends ChangeNotifier {
  List<ActivityModel> activities = <ActivityModel>[
    ActivityModel(
        activityId: "",
        activityType: "",
        date: "",
        redirectId: "",
        paymentActivityId: null,
        name: null,
        status: null,
        amount: null,
        groupName: null,
        transactionActivityId: null),
  ];
  // String _activityId = "";
  // String _activityType = "";
  // String _date = "";
  // String _redirectId = "";
  // String _detail = "";

  // String get activityId => _activityId;
  // String get activityType => _activityType;
  // String get date => _date;
  // String get redirectId => _redirectId;
  // String get detail => _detail;

  void loadActivityData(dynamic modelList) {
    List<ActivityModel> builder = activities;
    builder.clear();
    if (modelList != null) {
      for(int i = 0; i < modelList?.length; i++) {
        if(modelList[i]['activity_type'] == "PAYMENT"){
          builder.add(ActivityModel(
          activityId: modelList[i]['activity_id'],
          activityType: modelList[i]['activity_type'],
          date: modelList[i]['date'],
          redirectId: modelList[i]['redirect_id'],
          paymentActivityId: modelList[i]['detail']['payment_activity_id'],
          name: modelList[i]['detail']['name'],
          status: modelList[i]['detail']['status'],
          amount: modelList[i]['detail']['amount'],
          groupName: modelList[i]['detail']['group_name'],
        ));
        } else {
          builder.add(ActivityModel(
            activityId: modelList[i]['activity_id'],
            activityType: modelList[i]['activity_type'],
            date: modelList[i]['date'],
            redirectId: modelList[i]['redirect_id'],
            name: modelList[i]['detail']['name'],
            groupName: modelList[i]['detail']['group_name'],
            transactionActivityId: modelList[i]['detail']['transaction_activity_id'],
          ));
        }
      }
    }
    notifyListeners();
  }
}

final activityProvider = ChangeNotifierProvider((ref) => ActivityProvider());