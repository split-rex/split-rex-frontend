import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/routes.dart';

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
                      alignment: Alignment.centerLeft,
                      children: [
                        ref.watch(routeProvider).currentPage !=
                                    ("group_list") &&
                                ref.watch(routeProvider).currentPage !=
                                    ("activity") &&
                                ref.watch(routeProvider).currentPage !=
                                    ("account")
                            ?
                             InkWell(
                                onTap: () => ref
                                    .watch(routeProvider)
                                    .changePage(prevPage),
                                child: const Positioned(
                                    child: Icon(Icons.navigate_before,
                                        color: Color(0XFF4F4F4F), size: 35)),
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
                            ? Align(
                                widthFactor: 5.5,
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                    onTap: () => 
                                    ref
                                        .watch(routeProvider)
                                        .changePage("friends"),
                                    child: const Text("All Friends",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4F9A99),
                                        ))),
                              )
                            : const SizedBox(width: 0)
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
