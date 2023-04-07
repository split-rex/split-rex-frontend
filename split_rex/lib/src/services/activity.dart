import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:split_rex/src/providers/activity.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';

class ActivityServices {
  String endpoint = "https://split-rex-backend-7v6i6rndga-et.a.run.app";

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

  Future<void> getActivity(WidgetRef ref) async {
    Response resp = await get(
      Uri.parse("$endpoint/getUserActivity"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(activityProvider).loadActivityData(data["data"]);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }


}
