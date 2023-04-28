import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';
import 'package:split_rex/src/providers/transaction.dart';
import 'package:split_rex/src/widgets/expense/transaction_detail.dart';

class TransactionDetail extends ConsumerWidget {
  const TransactionDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: header(
        context, 
        ref,
        "Transaction Detail",
        "/group_detail",
        Container(
          padding: const EdgeInsets.only(top: 16.0),
          child: 
          ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height
          ),
          child: 
          SingleChildScrollView(
            child: 
            Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 75.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                transactionInfo(ref),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: const Color.fromARGB(30, 79, 79, 79), width: 1.0),
                  ),
                  margin: const EdgeInsets.only(top: 18.0),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      listItems(ref),
                      const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          summaryItems(ref, "Subtotal"),
                          summaryItems(ref, "Tax"),
                          summaryItems(ref, "Service charge"),
                          const SizedBox(height: 8.0,),
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total amount", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                          Text(
                            ref.watch(transactionProvider).currTrans.total.toString(), 
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            )
                          ),
                        ],
                      ),
                    ]),
                  )
                ])
              ),
            )
          ),
        )
      ),
    );
  }
}
