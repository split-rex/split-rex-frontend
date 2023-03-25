import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';


import '../common/logger.dart';

class ScanBillServices {
  String endpoint = "";

  Future<void> postBill(WidgetRef ref, File file) async {

    Response resp = await post(Uri.parse("$endpoint/"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${ref.watch(authProvider).jwtToken}"
      },
      body: jsonEncode(<String, dynamic>{
        "name": "tes"
      }
    ));
    var data = jsonDecode(resp.body);
    logger.d(data);
    if (data["message"] == "SUCCESS") {
      
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }
}
