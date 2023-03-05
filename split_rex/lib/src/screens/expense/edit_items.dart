import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';

import 'package:split_rex/src/widgets/expense/edit_items.dart';

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
                            dateTimeField(ref),
                            const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
                            listItem(ref),
                            const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
                            addItem(ref),
                            const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
                            const Text("Summary", textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                            const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                summaryField("Subtotal"),
                                summaryField("Tax"),
                                summaryField("Service charge"),
                                summaryField("Discounts"),
                                const SizedBox(height: 14.0),
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