import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/add_expense.dart';
import 'package:split_rex/src/providers/friend.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

import '../common/functions.dart';


Widget searchBar() => Container(
      margin: const EdgeInsets.only(left: 18.0, right: 18.0),
      decoration: BoxDecoration(
        color: const Color(0XFFFFFFFF),
        border: Border.all(
            color: const Color.fromARGB(50, 154, 154, 176), width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: const [
          Icon(
            Icons.search,
            color: Color(0XFF9A9AB0),
          ),
          SizedBox(width: 8.0),
          Text("Search for a friend.....",
              style: TextStyle(color: Color(0XFF9A9AB0)))
        ],
      ),
    );

Widget addFriendToGroup(BuildContext context, WidgetRef ref) {
  return Container(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(top: 8.0),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                    bottomLeft: Radius.circular(4.0),
                    bottomRight: Radius.circular(4.0)),
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: ref.watch(friendProvider).friendList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: ref.watch(addExpenseProvider).existingGroup.members.isNotEmpty
                          ? null
                          : () {
                              ref
                                  .read(addExpenseProvider)
                                  .changeSelectedFriends(ref.watch(friendProvider).friendList[index]);
                            },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Initicon(
                              text: ref
                                    .watch(friendProvider)
                                    .friendList[index]
                                    .name,
                              size: 40,
                              backgroundColor: getProfileBgColor(
                                ref
                                    .watch(friendProvider)
                                    .friendList[index]
                                    .color
                                ),
                              style: TextStyle(
                                color: getProfileTextColor(
                                  ref
                                    .watch(friendProvider)
                                    .friendList[index]
                                    .color
                                )
                              ), 
                            ),
                            const SizedBox(width: 16),
                            Text(
                                ref
                                    .watch(friendProvider)
                                    .friendList[index]
                                    .name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: 
                                  ref
                                          .watch(addExpenseProvider)
                                          .existingGroup.members.isNotEmpty
                                      ? const Color.fromARGB(130, 79, 79, 79) :
                                       const Color(0XFF4F4F4F),
                                ))
                          ]),
                          Checkbox(
                              value: ref
                                      .watch(addExpenseProvider)
                                      .newGroup.memberId
                                      .contains(ref.watch(friendProvider).friendList[index].userId)
                                  ? true
                                  : false,
                              onChanged:
                                  ref.watch(addExpenseProvider).existingGroup.members.isNotEmpty
                                      ? null
                                      : (bool? value) {
                                          ref
                                              .read(addExpenseProvider)
                                              .changeSelectedFriends(ref.watch(friendProvider).friendList[index]);
                                        })
                        ],
                      ));
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                        thickness: 1, height: 28.0, color: Color(0XFFE1F3F2)),
              ),
            ))
          ]));
}
