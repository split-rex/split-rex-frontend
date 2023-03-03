import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:split_rex/src/providers/routes.dart';

import '../services/add_expense.dart';

Widget splitButton(WidgetRef ref) => GestureDetector(
  onTap: () async {
    await FriendServices().createGroup(ref);
    ref.watch(routeProvider).changePage("home");
  },
  child: Container(
    alignment: Alignment.bottomCenter,
    height: 72,
    child:
    Container(
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(
          offset: Offset(0, 5.0),
          blurRadius: 15,
          color: Color.fromARGB(59, 0, 0, 0),
        )],
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Color(0XFF6DC7BD),
        ),
        child: const Text("Add Expense", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))
      )
    )
  )
);