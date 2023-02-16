import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiServices {
  String endpoint = 'http://10.0.2.2:8080';

  Future<bool> postRegister(name, username, email, pass) async {
    Response resp = await post(
      Uri.parse("$endpoint/register"),
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        "name": name,
        "email": email,
        "username": username,
        "password": pass
      })
    );
    if (resp.statusCode == 202) {
      return true;
    } else {
      throw Exception(resp.reasonPhrase);
    }
  }

  postLogin(email, pass) async {
    Response resp = await post(
      Uri.parse("$endpoint/login"),
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        "email": "samuel@gmail.com",
        "password": "sem"
      })
    );
    if (resp.statusCode == 202) {
      print("sabi");
      return true;
    } else {
      throw Exception(resp.reasonPhrase);
    }
  }
}

final userProvider = Provider<ApiServices>((ref) => ApiServices());
final userDataProvider = FutureProvider((ref) async {
  return ref.watch(userProvider);
});