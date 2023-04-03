import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:split_rex/src/common/bubble_member.dart';
import 'package:split_rex/src/common/functions.dart';
import 'package:split_rex/src/model/group_model.dart';
import 'package:split_rex/src/providers/friend.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:split_rex/src/services/add_expense.dart';

import '../providers/group_list.dart';

class GroupInfo extends ConsumerWidget {
  const GroupInfo(
      {super.key,
      required this.title,
      required this.startDate,
      required this.endDate,
      required this.totalExpense,
      required this.members,
      required this.prevPage});
  final String title;
  final String startDate;
  final String endDate;
  final int totalExpense;
  final List<dynamic> members;
  final String prevPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () => {
                        ref.read(routeProvider).changeNavbarIdx(1),
                        ref.watch(routeProvider).changePage(prevPage),
                      },
                  child: const Icon(Icons.navigate_before,
                      color: Colors.white, size: 35)),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  
                  
                  ref.watch(routeProvider).changePage("group_settings");
                },
                child:
                    const Icon(Icons.settings, color: Colors.white, size: 30),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 8, left: 10),
            child: Row(
              children: [
                Text(
                  "Rp${ref.watch(groupListProvider).currGroup.totalExpense}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                getBubbleMember(members)
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  convertDate(
                          ref.watch(groupListProvider).currGroup.startDate) +
                      " - " +
                      convertDate(
                          ref.watch(groupListProvider).currGroup.endDate),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BalanceInfo extends ConsumerWidget {
  const BalanceInfo({super.key, required this.totalUnpaid});
  final int totalUnpaid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        decoration: const BoxDecoration(
          color: Color(0X25FFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              flex: 7,
              child: Row(
                children: [
                  const SizedBox(width: 8.0),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                              text:
                                  ref.watch(groupListProvider).currGroup.type ==
                                          "EQUAL"
                                      ? "You are all settled up "
                                      : ref
                                                  .watch(groupListProvider)
                                                  .currGroup
                                                  .type ==
                                              "LENT"
                                          ? "You lent "
                                          : "You owe "),
                          TextSpan(
                              text: ref
                                          .watch(groupListProvider)
                                          .currGroup
                                          .type ==
                                      "EQUAL"
                                  ? ""
                                  : "Rp${ref.watch(groupListProvider).currGroup.totalUnpaid.toString().replaceAll('-', '')}",
                              style: TextStyle(
                                color: ref
                                            .watch(groupListProvider)
                                            .currGroup
                                            .type ==
                                        "OWED"
                                    ? const Color(0XFFF10D0D)
                                    : const Color(0xFF4F9A99),
                                fontWeight: FontWeight.w800,
                              )),
                          TextSpan(
                              text:
                                  ref.watch(groupListProvider).currGroup.type ==
                                          "EQUAL"
                                      ? ""
                                      : " in total"),
                        ]),
                  ),
                ],
              )),
        ]));
  }
}

class GroupDetailHeader extends ConsumerWidget {
  const GroupDetailHeader(
      {super.key, required this.group, required this.prevPage});

  final GroupListModel group;
  final String prevPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFF59C4B0),
            Color(0XFF43A7B7),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        padding: const EdgeInsets.only(
            top: 72.0, right: 28.0, left: 28.0, bottom: 20.0),
        child: Column(children: [
          GroupInfo(
            title: group.name,
            startDate: group.startDate,
            endDate: group.endDate,
            totalExpense: group.totalExpense,
            members: group.members,
            prevPage: prevPage,
          ),
          const SizedBox(height: 16),
          BalanceInfo(
            totalUnpaid: group.totalUnpaid,
          )
        ]));
  }
}

class GroupDetailContent extends ConsumerWidget {
  const GroupDetailContent({super.key, required this.group});

  final GroupListModel group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
        type: MaterialType.transparency,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0XFFE0F2F1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 40.0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 7,
                      child: InkWell(
                        onTap: () {
                          ref.watch(routeProvider).changePage("group_list");
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Color(0xFFDFF2F0),
                          ),
                          child: const Text(
                            "Unsettled Payments",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF4F9A99),
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                      flex: 7,
                      child: InkWell(
                        onTap: () {
                          ref.watch(routeProvider).changePage("group_list");
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: Color(0xFFDFF2F0),
                          ),
                          child: const Text(
                            "Confirmed Payments",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF4F9A99),
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: ref
                          .watch(groupListProvider)
                          .currGroup
                          .transactions
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return TransactionItem(
                            key: UniqueKey(),
                            listIdx: ref
                                    .watch(groupListProvider)
                                    .currGroup
                                    .transactions
                                    .length -
                                1 -
                                index);
                      })),
            ],
          ),
        ));
  }
}

class MonthSeparator extends StatelessWidget {
  final String month;

  const MonthSeparator({required this.month});

  @override
  Widget build(BuildContext context) {
    var currmonth = getFullMonthName(month);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Text(
        "$currmonth 2023",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}

class TransactionItem extends ConsumerStatefulWidget {
  final int listIdx;

  const TransactionItem({super.key, required this.listIdx});

  @override
  TransactionItemState createState() => TransactionItemState();
}

class TransactionItemState extends ConsumerState<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    var transaction =
        ref.watch(groupListProvider).currGroup.transactions[widget.listIdx];
    var currentMonth = extractMonth(transaction.date);
    log(widget.listIdx.toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.listIdx ==
                ref.watch(groupListProvider).currGroup.transactions.length -
                    1 ||
            currentMonth !=
                extractMonth(ref
                    .watch(groupListProvider)
                    .currGroup
                    .transactions[widget.listIdx + 1]
                    .date))
          MonthSeparator(month: currentMonth),
        InkWell(
            onTap: () async {
              await AddExpenseServices()
                  .getTransactionDetail(ref, transaction.transactionId);
              ref.read(routeProvider).changePage("transaction_detail");
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        extractMonth(transaction.date),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF9A9AB0),
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        extractDate(transaction.date),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Color(0XFF9A9AB0),
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffcff2ff),
                      ),
                      height: 35,
                      width: 35,
                      child: const Initicon(
                        text: "",
                        size: 16.0,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.name,
                        style: const TextStyle(
                          color: Color(0XFF9A9AB0),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Rp${transaction.total}",
                        style: const TextStyle(
                          color: Color(0XFF9A9AB0),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }
}
