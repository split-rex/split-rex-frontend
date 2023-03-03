import 'package:flutter/material.dart';
import 'package:split_rex/src/common/header.dart';
import 'package:split_rex/src/common/profile_picture.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/add_expense.dart';
import 'package:split_rex/src/providers/friend.dart';
import 'package:split_rex/src/widgets/split_bill.dart';


class SplitBill extends ConsumerWidget {
  const SplitBill({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
      context, 
      ref,
      "Split Bill",
      "edit_items",
      Stack(
        children: [
          SingleChildScrollView(child: 
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 75.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
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
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color.fromARGB(30, 79, 79, 79), width: 1.0),
                      ),
                      margin: const EdgeInsets.only(top: 18.0),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: 
                              Row(children: [
                                for (int index in ref.watch(addExpenseProvider).selectedFriendsIdx) 
                                  Row(children: [
                                    Column(children: [
                                      profilePicture(ref.watch(friendProvider).friendList[index].name, 32.0),
                                      Text(ref.watch(friendProvider).friendList[index].name, style: const TextStyle(fontSize: 12)),
                                  ]), 
                                  const SizedBox(width: 12.0)
                                ])
                              ])
                            ),
                        const Divider(thickness: 1, height: 24.0, color: Color.fromARGB(30, 79, 79, 79)),
                        ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 0, left: 8.0, right: 8.0, bottom: 12.0),
                          itemCount: ref.watch(addExpenseProvider).itemsName.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        ref.watch(addExpenseProvider).itemsName[index], 
                                        style: const TextStyle(
                                          color: Color(0XFF4F4F4F),
                                      ),),
                                      value: ref.watch(addExpenseProvider).selectedGroupIdx == index ? true : false,
                                      tileColor: Colors.white,
                                      onChanged: (ref.watch(addExpenseProvider).checkedFriends || ref.watch(addExpenseProvider).checkedGroups) && ref.watch(addExpenseProvider).selectedGroupIdx != index ? null : (bool? value) {
                                          ref.read(addExpenseProvider).changeSelectedGroup(index);
                                      },
                                    ),
                                    SizedBox(
                                      width: 340,
                                      child: 
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("${ref.watch(addExpenseProvider).itemsQty[index]} x"),
                                          const SizedBox(width: 36),
                                          Text("Rp ${ref.watch(addExpenseProvider).itemsPrice[index]}", style: const TextStyle(fontWeight: FontWeight.w700)),
                                        ],
                                      )
                                    )
                                ],)
                            )],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
                        ),
                        const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Subtotal", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.w600)),
                                Text("120.000", style: TextStyle(fontWeight: FontWeight.w600)),
                              ]
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Tax", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.w600)),
                                Text("20.000", style: TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Service charge", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.w600)),
                                Text("10.000", style: TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Discounts", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.w600)),
                                Text("0", style: TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                        ]),
                        Container(
                          margin: const EdgeInsets.only(right: 8.0),    
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Total amount", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                              Text("150.000", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                          ]),
                        ),
                        ],
                      )
                    ),
                  ),
                ),
                Align(alignment: Alignment.bottomCenter, child: splitButton(ref))
              ])
            );
  }
}
