import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/group_model.dart';

import '../common/profile_picture.dart';
import '../providers/group_list.dart';

class GroupInfo extends ConsumerWidget {
  const GroupInfo(
      {super.key,
      required this.title,
      required this.startDate,
      required this.endDate,
      required this.totalExpense,
      required this.memberId});
  final String title;
  final String startDate;
  final String endDate;
  final double totalExpense;
  final List<dynamic> memberId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      type: MaterialType.transparency,
      child: Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            Text(
              "$startDate-$endDate",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ]),
          const SizedBox(width: 80),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              "Rp.$totalExpense",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.red,
                      child: profilePicture(
                          "Pak Fitra", 16.0), // Provide your custom image
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.red,
                      child: profilePicture(
                          "Michael Jordan", 16.0), // Provide your custom image
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.red,
                      child: profilePicture(
                          "John Doe", 16.0), // Provide your custom image
                    ),
                  ),
                ),
              ],
            ),
          ])
        ],
      ),
    );
  }
}

class BalanceInfo extends ConsumerWidget {
  const BalanceInfo({super.key, required this.totalUnpaid});
  final double totalUnpaid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
                          const TextSpan(text: "You owe "),
                          TextSpan(
                              text: totalUnpaid.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700)),
                          const TextSpan(text: " in total!"),
                        ]),
                  ),
                ],
              )),
        ]));
  }
}

class GroupDetailHeader extends ConsumerWidget {
  const GroupDetailHeader({super.key, required this.group});

  final GroupListModel group;

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
            top: 72.0, right: 28.0, left: 28.0, bottom: 40.0),
        child: Column(children: [
          GroupInfo(
            title: group.name,
            startDate: group.startDate,
            endDate: group.endDate,
            totalExpense: group.totalExpense,
            memberId: group.memberId,
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFFFFF),
                Color(0XFFE0F2F1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
             )
          ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "February 2023",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: ref.watch(groupListProvider).groups.length,
                  itemBuilder: (BuildContext context, int index) {
                    return const TransactionItem();
                  })),
        ],
      ),
    ));
  }
}

class TransactionItem extends ConsumerWidget {
  const TransactionItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
            children: const [
              Text(
                "Feb",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0XFF9A9AB0),
                  fontSize: 20, 
                ),
              ),
              Text(
                "12",
                style: TextStyle(
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
              child: profilePicture("Muhammad Ali", 16.0)),
          const SizedBox(
            width: 20,
          ),
          const Text(
            "Francesco paid Luka Rp.120.000",
            style: TextStyle(
              color: Color(0XFF9A9AB0),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
