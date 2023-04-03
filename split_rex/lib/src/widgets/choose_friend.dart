import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/add_expense.dart';
import 'package:split_rex/src/providers/friend.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:split_rex/src/providers/group_settings.dart';
import 'package:split_rex/src/providers/routes.dart';

import '../common/functions.dart';

Widget searchBar(BuildContext context, WidgetRef ref) => Container(
      margin: const EdgeInsets.only(left: 18.0, right: 18.0),
     
      decoration: BoxDecoration(
        color: const Color(0XFFFFFFFF),
        border: Border.all(
            color: const Color.fromARGB(50, 154, 154, 176), width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
      ),
      padding: const EdgeInsets.all(12.0),
      child: 

      Row(
  children: [
    const Icon(
      Icons.search,
      color: Color(0XFF9A9AB0),
    ),
    const SizedBox(width: 8.0),
    Flexible(
      fit: FlexFit.tight,
      child: TextField(
        onChanged: (text) {
          log(text);
        },
        decoration: const InputDecoration(
          suffix: InkWell(
            child: Icon(
              Icons.filter_alt,
              color: Colors.grey,
            ),
          ),
          hintText: "Search for a friend....",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    ),
    const SizedBox(width: 8.0),
  ],
),

);

Widget searchBarInSettings(BuildContext context, WidgetRef ref) => Container(
      margin: const EdgeInsets.only(left: 18.0, right: 18.0),
     
      decoration: BoxDecoration(
        color: const Color(0XFFFFFFFF),
        border: Border.all(
            color: const Color.fromARGB(50, 154, 154, 176), width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(14.0)),
      ),
      padding: const EdgeInsets.all(12.0),
      child: 

        Row(
          children: [
            const Icon(
              Icons.search,
              color: Color(0XFF9A9AB0),
            ),
            const SizedBox(width: 8.0),
            Flexible(
              fit: FlexFit.tight,
              child: TextField(
                onChanged: (text) {
                  ref.read(friendProvider.notifier).searchFriendNotInGroup(text);
                },
                decoration: const InputDecoration(
                  suffix: InkWell(
                    child: Icon(
                      Icons.filter_alt,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "Search for a friend....",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
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
                itemCount: ref.watch(friendProvider).friendNotInGroup.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap:() {
                              ref
                                  .read(groupSettingsProvider)
                                  .changeSelectedFriends(ref
                                      .watch(friendProvider)
                                      .friendNotInGroup[index]);
                              
                            },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Initicon(
                              text: ref
                                  .watch(friendProvider)
                                  .friendNotInGroup[index]
                                  .name,
                              size: 40,
                              backgroundColor: getProfileBgColor(ref
                                  .watch(friendProvider)
                                  .friendNotInGroup[index]
                                  .color),
                              style: TextStyle(
                                  color: getProfileTextColor(ref
                                      .watch(friendProvider)
                                      .friendNotInGroup[index]
                                      .color)),
                            ),
                            const SizedBox(width: 16),
                            Text(
                                ref
                                    .watch(friendProvider)
                                    .friendNotInGroup[index]
                                    .name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Color(0XFF4F4F4F),
                                ))
                          ]),
                          Checkbox(
                              value: ref
                                      .watch(groupSettingsProvider)
                                      .memberId
                                      .contains(ref
                                          .watch(friendProvider)
                                          .friendNotInGroup[index]
                                          .userId)
                                  ? true
                                  : false,
                              onChanged: ref
                                      .watch(groupSettingsProvider)
                                      .existingGroup
                                      .members
                                      .isNotEmpty
                                  ? null
                                  : (bool? value) {
                                      ref
                                          .read(groupSettingsProvider)
                                          .changeSelectedFriends(ref
                                              .watch(friendProvider)
                                              .friendNotInGroup[index]);
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

Widget addFriendToGroupButton(WidgetRef ref) => GestureDetector(
    onTap: () {
      if (
          ref.watch(groupSettingsProvider).memberId.isNotEmpty) {
            // ref.watch(routeProvider).changePage("group_settings");
            log(ref.watch(groupSettingsProvider).memberId.toString());
      } else {
        null;
      }
    },
    child: Container(
        alignment: Alignment.bottomCenter,
        height: 72,
        child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5.0),
                  blurRadius: 15,
                  color: Color.fromARGB(59, 0, 0, 0),
                )
              ],
              color: Colors.white,
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
            child: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  color: ref.watch(groupSettingsProvider).memberId.isNotEmpty
                      ? const Color(0XFF6DC7BD)
                      : const Color.fromARGB(50, 79, 79, 79),
                ),
                child: const Text("Add to Group",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700))))));

