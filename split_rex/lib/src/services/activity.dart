import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/activity.dart';
import 'package:split_rex/src/providers/group_list.dart';

class ActivityService {
  Future<void> readJson(WidgetRef ref) async {
    final String response =
        await rootBundle.loadString('assets/userActivity.json');

    var data = await json.decode(response);
    ref.read(activityProvider).loadActivityData(data["data"]);
    // setState(() {
    //   _items = data["items"];
    //   print("..number of items ${_items.length}");
    // });
  
  }

}
