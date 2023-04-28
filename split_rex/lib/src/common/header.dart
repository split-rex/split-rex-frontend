import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_rex/src/providers/add_expense.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/firebaseauth.dart';
import 'package:split_rex/src/providers/friend.dart';
import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/services/friend.dart';
import 'package:split_rex/src/services/group.dart';

Widget header(BuildContext context, WidgetRef ref, String pagename,
        String prevPage, Widget widget) =>
    Container(
        color: const Color(0XFFFFFFFF),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    height: 120,
                    padding: const EdgeInsets.only(
                        top: 50.0, bottom: 10.0, left: 5.0, right: 5.0),
                    child: Stack(
                      alignment:
                          ref.watch(routeProvider).currentPage == "account"
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      children: [
                        ref.watch(routeProvider).currentPage !=
                                    ("group_list") &&
                                ref.watch(routeProvider).currentPage !=
                                    ("activity") &&
                                ref.watch(routeProvider).currentPage !=
                                    ("account")
                            ? Container(
                                width: MediaQuery.of(context).size.width - 20.0,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(left: 20),
                                child: InkWell(
                                  onTap: () async { 
                                    if (prevPage == "add_expense") {
                                      ref.read(addExpenseProvider).resetNewGroup();
                                    }
                                    if (prevPage == "group_detail") {
                                      // await GroupServices().userGroupList(ref);
                                      await GroupServices().getGroupDetail(ref, ref.watch(groupListProvider).currGroup.groupId);
                                    }
                                    ref
                                      .watch(routeProvider)
                                      .changePage(prevPage);
                                  },
                                  child: const Icon(Icons.navigate_before,
                                      color: Color(0XFF4F4F4F), size: 35),
                                ))
                            : const SizedBox(width: 0),
                        Container(
                          width: MediaQuery.of(context).size.width - 10.0,
                          alignment: Alignment.center,
                          child: Text(
                            pagename,
                            style: const TextStyle(
                                color: Color(0XFF4F4F4F),
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ),
                        ref.watch(routeProvider).currentPage == ("group_list")
                            ? Container(
                                width: MediaQuery.of(context).size.width - 20.0,
                                padding: const EdgeInsets.only(right: 20),
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                    onTap: () async {
                                      await FriendServices()
                                          .userFriendList(ref);
                                      await FriendServices()
                                          .friendRequestReceivedList(ref);
                                      await FriendServices()
                                          .friendRequestSentList(ref);
                                      ref
                                          .watch(routeProvider)
                                          .changePage("friends");
                                    },
                                    child: const Text("All Friends",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4F9A99),
                                        ))),
                              )
                            : const SizedBox(width: 0),
                        ref.watch(routeProvider).currentPage == ("settle_up")
                            ? Container(
                                width: MediaQuery.of(context).size.width - 20.0,
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                    onTap: () =>
                                        helpDialogUnsettledPayments(context),
                                    child: const Icon(
                                        Icons.help_outline_outlined)),
                              )
                            : const SizedBox(width: 0),
                        ref.watch(routeProvider).currentPage == ("settle_up")
                            ? Container(
                                width: MediaQuery.of(context).size.width - 20.0,
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                    onTap: () => helpDialogSettleUp(context),
                                    child: const Icon(
                                        Icons.help_outline_outlined)),
                              )
                            : const SizedBox(width: 0),
                        ref.watch(routeProvider).currentPage == ("account")
                            ? Container(
                                width: MediaQuery.of(context).size.width - 20.0,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                child: InkWell(
                                  onTap: () async {
                                    if (FirebaseAuth.instance.currentUser !=
                                        null) {
                                      log("firebase logout");
                                      await ref
                                          .watch(googleSignInProvider)
                                          .googleLogout();
                                    }

                                    await signOut(ref);
                                  },
                                  child: const Icon(Icons.logout,
                                      color: Color(0XFF4F4F4F), size: 24),
                                ))
                            : const SizedBox(width: 0),
                      ],
                    )),
              ],
            ),
            Expanded(
                child: Column(mainAxisSize: MainAxisSize.max, children: [
              Expanded(
                  child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0XFFE0F2F1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: widget))
            ]))
          ],
        ));

Future<void> signOut(WidgetRef ref) async {
  ref.read(groupListProvider).clearGroupListProvider();
  ref.read(friendProvider).clearFriendProvider();
  ref.read(authProvider).clearAuthProvider();
  ref.read(addExpenseProvider).resetAll();
  ref.read(routeProvider).clearRouteProvider();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('email');
  prefs.remove('password');
  prefs.remove('jwtToken');
}

helpDialogUnsettledPayments(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: [
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Color(0xFF15808D),
                ),
              )
            ]),
            const Icon(
              Icons.question_answer_rounded,
              color: Color(0xFF38AFA2),
              size: 58,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('How do we calculate these balances?',
            textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Balances are calculated using a graph algorithm.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'The algorithm goals is to minimize the amount of money transfers among group members. There will be no circular debts after the transaction is simplified.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '  These balances will automatically change after making new transaction.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    ),
  );
}

// TODO: delete kalo gaperlu buat settle up
helpDialogSettleUp(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: [
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Color(0xFF15808D),
                ),
              )
            ]),
            const Icon(
              Icons.question_answer_rounded,
              color: Color(0xFF38AFA2),
              size: 58,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('How do we calculate these balances?',
            textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Balances are calculated using a graph algorithm.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'The algorithm goals is to minimize the amount of money transfers among group members. There will be no circular debts after the transaction is simplified.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '  These balances will automatically change after making new transaction.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    ),
  );
}
