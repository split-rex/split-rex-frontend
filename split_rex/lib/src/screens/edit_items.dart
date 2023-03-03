import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';

import 'package:split_rex/src/widgets/edit_items.dart';
import 'package:split_rex/src/providers/add_expense.dart';


class EditItems extends ConsumerWidget {
  const EditItems({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
      context, 
      ref,
      "Edit Items",
      "add_expense",
      Stack(
        children: [
      SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 70,
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                          border: Border.all(color: const Color.fromARGB(30, 79, 79, 79), width: 1.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              onChanged: (val) {
                                ref.read(addExpenseProvider).changeStartDate(DateTime.now().toUtc().toIso8601String());
                                ref.read(addExpenseProvider).changeEndDate(DateTime.now().toUtc().toIso8601String());
                              },
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                                hintText: "${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}\t\t\t\t|\t\t\t\t${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}",
                                filled: true,
                                fillColor: const Color(0XFFF6F6F6),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none
                                ),
                              ),
                            ),
                            const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
                            ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              itemCount: ref.watch(addExpenseProvider).itemsName.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 340,
                                          margin: const EdgeInsets.only(bottom: 8.0),
                                          child: 
                                            TextField(
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                                                hintText: ref.watch(addExpenseProvider).itemsName[index],
                                                filled: true,
                                                fillColor: const Color(0XFFF6F6F6),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  borderSide: BorderSide.none
                                                ),
                                              ),
                                            ),
                                        ),
                                        SizedBox(
                                          width: 340,
                                          child: 
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              const Icon(Icons.delete, color: Color(0XFF6DC7BD)),
                                              Container(
                                                width: 60,
                                                margin: const EdgeInsets.only(left: 8.0),
                                                child: 
                                                TextField(
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                                                    hintText: "${ref.watch(addExpenseProvider).itemsQty[index]} x",
                                                    filled: true,
                                                    fillColor: const Color(0XFFF6F6F6),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      borderSide: BorderSide.none
                                                    ),
                                                  ),
                                                ), 
                                              ),
                                              Container(
                                                width: 150, 
                                                margin: const EdgeInsets.only(left: 8.0),
                                                child: 
                                                TextField(
                                                  textAlign: TextAlign.end,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                                                    hintText: "Rp ${ref.watch(addExpenseProvider).itemsPrice[index]}",
                                                    filled: true,
                                                    fillColor: const Color(0XFFF6F6F6),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      borderSide: BorderSide.none
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        )
                                    ],)
                                  ],
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
                            ),
                            const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
                            Row(children: const [
                              Icon(Icons.add, color: Color(0XFF2E9281)),
                              SizedBox(width: 16.0),
                              Text("Add Item", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0XFF2E9281)))
                            ],),
                            const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
                            const Text("Summary", textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                            const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Subtotal", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.w600)),
                                    Container(
                                      width: 150, 
                                      height: 40,
                                      padding: EdgeInsets.zero,
                                      child: 
                                      TextField(
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
                                          hintText: "120.000",
                                          filled: true,
                                          fillColor: const Color(0XFFF6F6F6),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Tax", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.w600)),
                                    Container(
                                      width: 150, 
                                      height: 40,
                                      padding: EdgeInsets.zero,
                                      child: 
                                      TextField(
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
                                          hintText: "20.000",
                                          filled: true,
                                          fillColor: const Color(0XFFF6F6F6),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Service charge", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.w600)),
                                    Container(
                                      width: 150, 
                                      height: 40,
                                      padding: EdgeInsets.zero,
                                      child: 
                                      TextField(
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
                                          hintText: "10.000",
                                          filled: true,
                                          fillColor: const Color(0XFFF6F6F6),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Discounts", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.w600)),
                                    Container(
                                      width: 150, 
                                      height: 40,
                                      padding: EdgeInsets.zero,
                                      child: 
                                      TextField(
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
                                          hintText: "0",
                                          filled: true,
                                          fillColor: const Color(0XFFF6F6F6),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 14.0),
                            ]),
                            Container(
                              margin: EdgeInsets.only(right: 8.0),    
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Total amount", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                                  const Text("150.000", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ),
            ],
          )

              )
          )
                  
                ),
                Align(alignment: Alignment.bottomCenter,
                child: 
          confirmButton(ref)
                )
        ],
      )
          
    );
  }
}
