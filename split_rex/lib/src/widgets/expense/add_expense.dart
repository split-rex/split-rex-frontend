import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/add_expense.dart';
import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/providers/routes.dart';

import 'package:split_rex/src/common/profile_picture.dart';

import '../../providers/friend.dart';

Widget searchBar(WidgetRef ref) => Container(
  margin: const EdgeInsets.only(left: 18.0, right: 18.0),
  decoration: BoxDecoration(
    color: const Color(0XFFFFFFFF),
    border: Border.all(
        color: const Color.fromARGB(50, 154, 154, 176), width: 1.0),
    borderRadius: const BorderRadius.all(Radius.circular(14.0)),
  ),
  padding: const EdgeInsets.symmetric(horizontal: 12.0),
  child: TextField(
    onChanged: (val) {
      ref.read(groupListProvider).searchGroupName(val);
      ref.read(friendProvider).searchFriendName(val);
    },
    decoration: const InputDecoration(
      icon: Icon(
        Icons.search,
        color: Color(0XFF9A9AB0),
      ),
      hintText: "Search group or friends name....",
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      contentPadding: EdgeInsets.zero
    ),
  )
);

Widget addExistingGroup(BuildContext context, WidgetRef ref) {
  return Container(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Add to an existing group:",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w800,
            )),
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(
              top: 0, left: 4.0, right: 4.0, bottom: 16.0),
          margin: const EdgeInsets.only(top: 8.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: ref.watch(groupListProvider).groupsLoaded.isEmpty ? 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("You don't have existing groups"),
              Text("\nTry adding expense to create groups")
            ],
          ) :
          ref.watch(groupListProvider).groups.isEmpty ?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("You don't have any groups with that name"),
                ],
          ) : 
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: ref.watch(groupListProvider).groups.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckboxListTile(
                title: Text(
                  ref.watch(groupListProvider).groups[index].name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16),
                ),
                value: ref.watch(addExpenseProvider).existingGroup.groupId == ref.watch(groupListProvider).groups[index].groupId,
                tileColor: Colors.white,
                onChanged: (ref.watch(addExpenseProvider).newGroup.memberId.isNotEmpty ||
                            ref.watch(addExpenseProvider).existingGroup.memberId.isNotEmpty) &&
                        ref.watch(addExpenseProvider).existingGroup.groupId != ref.watch(groupListProvider).groups[index].groupId
                    ? null
                    : (bool? value) {
                        ref.read(addExpenseProvider).changeSelectedGroup(ref.watch(groupListProvider).groups[index]);
                      },
                checkboxShape: const CircleBorder(),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                    thickness: 1, height: 28.0, color: Color(0XFFE1F3F2)),
          ),
        ))
      ]));
}

Widget addNewGroup(BuildContext context, WidgetRef ref) {
  return Container(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
      margin: const EdgeInsets.only(top: 16.0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Or create a new group:",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                )),
            Expanded(
              child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(top: 8.0),
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                    bottomLeft: Radius.circular(4.0),
                    bottomRight: Radius.circular(4.0)),
              ),
              child: ref.watch(friendProvider).friendList.isEmpty ? 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("You don't have any friends"),
                    Text("\nTry adding friends first!")
                  ],
                ) : 
                ref.watch(friendProvider).friendSearched.isEmpty ?
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("You don't have any friends with that name"),
                  ],
                ) : 
                ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: ref.watch(friendProvider).friendSearched.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: ref.watch(addExpenseProvider).existingGroup.memberId.isNotEmpty
                          ? null
                          : () {
                              ref
                                  .read(addExpenseProvider)
                                  .changeSelectedFriends(ref.watch(friendProvider).friendSearched[index]);
                            },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            profilePicture(
                                ref
                                    .watch(friendProvider)
                                    .friendSearched[index]
                                    .name,
                                24.0),
                            const SizedBox(width: 16),
                            Text(
                                ref
                                    .watch(friendProvider)
                                    .friendSearched[index]
                                    .name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: ref
                                          .watch(addExpenseProvider)
                                          .existingGroup.memberId.isNotEmpty
                                      ? const Color.fromARGB(130, 79, 79, 79)
                                      : const Color(0XFF4F4F4F),
                                ))
                          ]),
                          Checkbox(
                              value: ref
                                      .watch(addExpenseProvider)
                                      .newGroup.memberId.
                                      contains(ref.watch(friendProvider).friendSearched[index].userId),
                              onChanged:
                                  ref.watch(addExpenseProvider).existingGroup.memberId.isNotEmpty
                                      ? null
                                      : (bool? value) {
                                          ref
                                              .read(addExpenseProvider)
                                              .changeSelectedFriends(ref
                                                .watch(friendProvider)
                                                .friendSearched[index]
                                              );
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

Widget addButton(WidgetRef ref) => GestureDetector(
    onTap: () {
      ref.watch(addExpenseProvider).existingGroup.memberId.isNotEmpty ||
              ref.watch(addExpenseProvider).newGroup.memberId.isNotEmpty
          ? ref.read(routeProvider).changePage("edit_items")
          : null;
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
                  color: ref.watch(addExpenseProvider).existingGroup.memberId.isNotEmpty ||
                          ref.watch(addExpenseProvider).newGroup.memberId.isNotEmpty
                      ? const Color(0XFF6DC7BD)
                      : const Color.fromARGB(50, 79, 79, 79),
                ),
                child: const Text("Add",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700))))));
