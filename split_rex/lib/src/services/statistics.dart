import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:split_rex/src/common/const.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/providers/statisticsprovider.dart';
import 'package:split_rex/src/common/functions.dart';

class StatisticsServices {
  String endpoint = getUrl();
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

  Future<void> readJsonmutation(WidgetRef ref) async {
    final String response =
        await rootBundle.loadString('assets/mutation.json');

    var data = await json.decode(response);
    ref.read(statisticsProvider).loadPaymentMutation(data["data"]);
    // setState(() {
    //   _items = data["items"];
    //   print("..number of items ${_items.length}");
    // });
  
  }

  Future<void> owedLentPercentage(WidgetRef ref) async {
    
    Response resp = await get(
      Uri.parse("$endpoint/owedLentPercentage"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(statisticsProvider).loadPercentageData(data["data"]);
    } 
     else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> paymentMutation(WidgetRef ref) async {
    
    Response resp = await get(
      Uri.parse("$endpoint/paymentMutation?start_date=${formatDateJson(ref.watch(statisticsProvider).startSettleDate)}&end_date=${formatDateJson(ref.watch(statisticsProvider).endSettleDate)}"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(statisticsProvider).loadPaymentMutation(data["data"]);
    } 
     else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> expenseChart(WidgetRef ref) async {
    
    Response resp = await get(
      Uri.parse("$endpoint/expenseChart"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(statisticsProvider).loadExpenseChart(data["data"]);
    } 
     else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }
  
  Future<void> spendingBuddies(WidgetRef ref) async {
    
    Response resp = await get(
      Uri.parse("$endpoint/spendingBuddies"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(statisticsProvider).loadSpendingBuddies(data["data"]);
    } 
     else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> owedLentStatistics(WidgetRef ref) async {
    
    Response resp = await get(
      Uri.parse("$endpoint/owedLentPercentage"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
    );
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(statisticsProvider).loadPercentageData(data["data"]);
    } 
     else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }




}

