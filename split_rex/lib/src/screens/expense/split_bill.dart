import 'package:flutter/material.dart';
import 'package:split_rex/src/common/header.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/widgets/expense/split_bill.dart';


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
                  billNameField(ref),
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
                        membersScrollView(ref),
                        const Divider(thickness: 1, height: 24.0, color: Color.fromARGB(30, 79, 79, 79)),
                        listSplitItem(ref),
                        const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            summarySplit(ref, "Subtotal"),
                            summarySplit(ref, "Tax"),
                            summarySplit(ref, "Service charge"),
                            summarySplit(ref, "Discounts"),
                            const SizedBox(height: 8.0,),
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Total amount", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                            Text("150.000", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ]),
                    )
                  ])
                ),
              ),
            ),
          Align(alignment: Alignment.bottomCenter, child: splitButton(ref))
        ]
      )
    );
  }
}
