import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';

import '../providers/auth.dart';
import '../providers/routes.dart';

class Account extends ConsumerWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
      context, 
      ref,
      "Account",
      "home",
      GestureDetector(
        onTap: () {
          ref.read(authProvider).clearUserData();
          ref.read(routeProvider).changePage("sign_up");
        },
        child: Container(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF59C4B0),
                  Color(0XFF43A7B7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const Text("Sign Out", style: TextStyle(color: Color(0XFFFFFFFF), fontWeight: FontWeight.bold)),
          )
        ),
      )
    );
  }
}
