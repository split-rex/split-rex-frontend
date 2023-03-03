import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:split_rex/src/model/group_model.dart';

class GroupListProvider extends ChangeNotifier {
  List<GroupListModel> groups = <GroupListModel>[
    GroupListModel(0, "Trip2", [1, 2, 3, 4, 5, 6], "01-01-2023", "02-02-2023",
        "owed", 20.00, 35.00)
  ];

  void loadGroupData(dynamic modelList) {
    List<GroupListModel> builder = groups;
    builder.clear();
    for (int i = 0; i < modelList.length; i++) {
      builder.add(GroupListModel(
          modelList[i]["id"],
          modelList[i]["name"],
          modelList[i]["member_id"],
          modelList[i]["start_date"],
          modelList[i]["end_date"],
          modelList[i]["type"],
          modelList[i]["total_unpaid"],
          modelList[i]["total_expense"]));
    }

    groups = builder;
    notifyListeners();
  }
}

final groupListProvider = ChangeNotifierProvider((ref) => GroupListProvider());
