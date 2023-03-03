import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/add_expense.dart';

import 'package:split_rex/src/common/profile_picture.dart';

Widget searchBar() => Container(
  margin: const EdgeInsets.only(left: 18.0, right: 18.0),
  decoration: BoxDecoration(
    color: const Color(0XFFFFFFFF),
    border: Border.all(color: const Color.fromARGB(50, 154, 154, 176), width: 1.0),
    borderRadius: const BorderRadius.all(Radius.circular(14.0)),
  ),
  padding: const EdgeInsets.all(12.0),
  child: Row(
    children: const [
      Icon(
        Icons.search,
        color:Color(0XFF9A9AB0),
      ),
      SizedBox(width: 8.0),
      Text(
        "Search by name and username...", 
        style: TextStyle(color: Color(0XFF9A9AB0))
      )
    ],
  ),
);

Widget addExistingGroup(BuildContext context, WidgetRef ref) {
  return Container(
    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
    margin: const EdgeInsets.only(top: 16.0),
    child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const Text(
          "Add to an existing group:",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w800,
          )
        ),
        Expanded(child: 
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(top: 8.0),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: ref.watch(addExpenseProvider).groups.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  title: Text(
                    ref.watch(addExpenseProvider).groups[index], 
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16
                  ),),
                  value: ref.watch(addExpenseProvider).selectedGroupIdx == index ? true : false,
                  tileColor: Colors.white,
                  onChanged: (ref.watch(addExpenseProvider).checkedFriends || ref.watch(addExpenseProvider).checkedGroups) && ref.watch(addExpenseProvider).selectedGroupIdx != index ? null : (bool? value) {
                      ref.read(addExpenseProvider).changeSelectedGroup(index);
                  },
                  checkboxShape: const CircleBorder(),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1, height: 28.0, color: Color(0XFFE1F3F2)),
            ),
          )
        )
      ]
    )
  );
}

Widget addNewGroup(BuildContext context, WidgetRef ref) {
  return Container(
    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
    margin: const EdgeInsets.only(top: 16.0),
    child: 
      Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const Text(
          "Or create a new group:",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w800,
          )
        ),
        Expanded(child: 
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(top: 8.0),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0), bottomLeft: Radius.circular(4.0), bottomRight: Radius.circular(4.0)),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: ref.watch(addExpenseProvider).friends.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: ref.watch(addExpenseProvider).checkedGroups ? null : () {
                      ref.read(addExpenseProvider).changeSelectedFriends(index);
                    },
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        profilePicture(ref.watch(addExpenseProvider).friends[index]),
                        const SizedBox(width: 16),
                        Text(
                          ref.watch(addExpenseProvider).friends[index], 
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: ref.watch(addExpenseProvider).checkedGroups ? const Color.fromARGB(130, 79, 79, 79) : const Color(0XFF4F4F4F),
                          )
                        )
                      ]
                    ),
                    Checkbox(
                      value: ref.watch(addExpenseProvider).selectedFriendsIdx.contains(index) ? true : false, 
                      onChanged: ref.watch(addExpenseProvider).checkedGroups ? null : (bool? value) {
                        ref.read(addExpenseProvider).changeSelectedFriends(index);
                      }
                    )
                  ],
                ));
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1, height: 28.0, color: Color(0XFFE1F3F2)),
            ),
          )
        )
      ]
    )
  );
}

Widget addButton() => GestureDetector(
  onTap: () {
    null;
  },
  child: Container(
    alignment: Alignment.bottomCenter,
    height: double.infinity,
    child:
    Container(
      height: 72,
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(
          offset: Offset(0, 5.0),
          blurRadius: 15,
          color: Color.fromARGB(59, 0, 0, 0),
        )],
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Color(0XFF6DC7BD),
        ),
        child: const Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))
      )
    )
  )
);
