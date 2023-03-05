import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:split_rex/src/providers/add_expense.dart';

import '../../common/profile_picture.dart';
import '../../providers/auth.dart';
import '../../providers/friend.dart';
import '../../services/add_expense.dart';

Widget billNameField(WidgetRef ref) => Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16.0),
    border: Border.all(color: const Color.fromARGB(30, 79, 79, 79), width: 1.0),
  ),
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      SizedBox(
        width: 240,
        child:
        TextField(
          onChanged: (value) {
            ref.read(addExpenseProvider).changeBillName(value);
          },
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: Color(0XFF4F4F4F)
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: "Bill Name",
            hintStyle: const TextStyle(
              color: Color(0XFF9A9AB0)
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none
            ),
          ),
        ),
      ),
      const Icon(Icons.edit, size: 20, color: Color.fromARGB(150, 79, 79, 79))
    ],),
    const Divider(thickness: 1, height: 8.0, color: Color.fromARGB(30, 79, 79, 79)),
    Text("${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}\t\t\t\t|\t\t\t\t${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}", style: const TextStyle(fontWeight: FontWeight.w700))
  ],)
);

Widget membersScrollView(WidgetRef ref) => SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: 
  Row(children: [
    Row(children: [
        Column(children: [
          profilePicture(ref.watch(authProvider).userData.name, 32.0),
          const Text("You", style: TextStyle(fontSize: 12)),
      ]), 
      const SizedBox(width: 12.0),
      Row(children: [
        for (String memberId in ref.watch(addExpenseProvider).newGroup.memberId) 
          Row(children: [
            Column(children: [
              profilePicture((ref.watch(friendProvider).getFriend(memberId)).name, 32.0),
              Text((ref.watch(friendProvider).getFriend(memberId)).name, style: const TextStyle(fontSize: 12)),
          ]), 
          const SizedBox(width: 12.0)
        ])
      ])
  ],)
]));

Widget itemSplitCard(WidgetRef ref, int index) => Row(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            ref.watch(addExpenseProvider).items[index].name, 
            style: const TextStyle(
              color: Color(0XFF4F4F4F),
          ),),
          value: ref.watch(addExpenseProvider).items[index].selected,
          tileColor: Colors.white,
          onChanged: (val) {
            ref.read(addExpenseProvider).changeItemSelected(index);
          },
        ),
        SizedBox(
          width: 340,
          child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("${ref.watch(addExpenseProvider).items[index].qty} x"),
              const SizedBox(width: 36),
              Text("Rp ${ref.watch(addExpenseProvider).items[index].price}", style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          )
        )
    ],)
  )],
);

Widget listSplitItem(WidgetRef ref) => ListView.separated(
  shrinkWrap: true,
  padding: const EdgeInsets.only(top: 0, left: 8.0, right: 8.0, bottom: 12.0),
  itemCount: ref.watch(addExpenseProvider).items.length,
  itemBuilder: (BuildContext context, int index) {
    return itemSplitCard(ref, index);
  },
  separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
);

Widget summarySplit(WidgetRef ref, String title) => Column(children: [
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, textAlign: TextAlign.left, style: const TextStyle(fontWeight: FontWeight.w600)),
      const Text("120.000", style: TextStyle(fontWeight: FontWeight.w600)),
    ]
  ),
  const SizedBox(height: 12.0)
],); 

Widget splitButton(WidgetRef ref) => GestureDetector(
  onTap: () async {
    ref.watch(addExpenseProvider).newGroup.name == "" ? null :
    await FriendServices().createGroup(ref);
  },
  child: Container(
    alignment: Alignment.bottomCenter,
    height: 72,
    child:
    Container(
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
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: ref.watch(addExpenseProvider).newGroup.name == "" ? const Color.fromARGB(50, 79, 79, 79) : const Color(0XFF6DC7BD),
        ),
        child: const Text("Add Expense", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))
      )
    )
  )
);