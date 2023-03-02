import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/group_list.dart';

import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/model/auth.dart';

class ApiServices {
  String endpoint = "http://10.10.75.234:8080";

  Future<void> postRegister(WidgetRef ref) async {
    SignUpModel signUpData = ref.watch(authProvider).signUpData;
    if (signUpData.confPass != signUpData.pass) {
      throw Exception();
    }
    Response resp = await post(Uri.parse("$endpoint/register"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          "name": signUpData.name,
          "email": signUpData.email,
          "username": signUpData.username,
          "password": signUpData.pass
        }));
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(routeProvider).changeLogged();
      ref.read(routeProvider).currentPage = "home";
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> postLogin(WidgetRef ref) async {
    SignInModel signInData = ref.watch(authProvider).signInData;
    Response resp = await post(Uri.parse("$endpoint/login"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          "email": signInData.email,
          "password": signInData.pass
        }));
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      ref.read(routeProvider).changeLogged();
      ref.read(routeProvider).currentPage = "home";
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> readJson(WidgetRef ref) async {
    final String response =
        await rootBundle.loadString('assets/groups.json');

    var data = await json.decode(response);
    ref.read(groupListProvider).loadGroupData(data["data"]);
    // setState(() {
    //   _items = data["items"];
    //   print("..number of items ${_items.length}");
    // });
  
  }
}
