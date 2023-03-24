import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/services/friend.dart';

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
                    child: Stack(alignment: Alignment.centerLeft, children: [
                      ref.watch(routeProvider).currentPage != ("group_list") &&
                              ref.watch(routeProvider).currentPage !=
                                  ("activity") &&
                              ref.watch(routeProvider).currentPage !=
                                  ("account")
                          ? InkWell(
                              onTap: () =>
                                  ref.watch(routeProvider).changePage(prevPage),
                              child: const Icon(Icons.navigate_before,
                                  color: Color(0XFF4F4F4F), size: 35),
                            )
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
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                  onTap: () async {
                                    await FriendServices().userFriendList(ref);
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
                      ref.watch(routeProvider).currentPage ==
                              ("unsettled_payments")
                          ? Container(
                              width: MediaQuery.of(context).size.width - 20.0,
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                  onTap: () => helpDialog(context),
                                  child:
                                      const Icon(Icons.help_outline_outlined)),
                            )
                          : const SizedBox(width: 0),
                      ref.watch(routeProvider).currentPage == ("settle_up")
                          ? Container(
                              width: MediaQuery.of(context).size.width - 20.0,
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                  onTap: () => helpDialog(context),
                                  child:
                                      const Icon(Icons.help_outline_outlined)),
                            )
                          : const SizedBox(width: 0)
                    ])),
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

helpDialog(context) {
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Yada yada yada jelasin cara kita ngebaginya ubai uabi uabia ubai ubai lorem ipsum sit amet dolorrrr',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Yada yada yada jelasin cara kita ngebaginya ubai uabi uabia ubai ubai lorem ipsum sit amet dolorrrr',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Yada yada yada jelasin cara kita ngebaginya ubai uabi uabia ubai ubai lorem ipsum sit amet dolorrrr',
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
