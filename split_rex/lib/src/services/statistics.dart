import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/statisticsprovider.dart';

class StatisticsServices {
  Future<void> readJson(WidgetRef ref) async {
    final String response =
        await rootBundle.loadString('assets/percentage.json');

    var data = await json.decode(response);
    ref.read(statisticsProvider).loadPercentageData(data["data"]);
    // setState(() {
    //   _items = data["items"];
    //   print("..number of items ${_items.length}");
    // });
  
  }
}