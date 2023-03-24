import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';
import 'package:split_rex/src/providers/firebaseauth.dart';
import 'package:split_rex/src/providers/group_list.dart';

import '../providers/add_expense.dart';
import '../providers/auth.dart';
import '../providers/friend.dart';
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
        onTap: () async {
          await _signOut(ref);
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

Future<void> _signOut(WidgetRef ref) async {
  if (FirebaseAuth.instance.currentUser != null) {
    await ref.read(googleSignInProvider).googleLogout();
  }
  ref.read(routeProvider).clearRouteProvider();
  ref.read(groupListProvider).clearGroupListProvider();
  ref.read(friendProvider).clearFriendProvider();
  ref.read(authProvider).clearAuthProvider();
  ref.read(addExpenseProvider).clearAddExpenseProvider();
}