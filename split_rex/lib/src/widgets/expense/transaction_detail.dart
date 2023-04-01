import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/transaction.dart';


Widget transactionInfo(WidgetRef ref) => Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16.0),
    border: Border.all(color: const Color.fromARGB(30, 79, 79, 79), width: 1.0),
  ),
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 240,
          child:
          Text(
            ref.watch(transactionProvider).currTrans.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0XFF4F4F4F)
            ),
          ),
        ),
      ],
    ),
    const SizedBox(height: 6),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 240,
          child:
          Text(
            ref.watch(transactionProvider).currTrans.groupName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Color(0XFF4F4F4F)
            ),
          ),
        ),
      ],
    ),
    const SizedBox(height: 16),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 240,
          child:
          Text(
            ref.watch(transactionProvider).currTrans.date,
            // TODO: uncomment yg dibawah
            // "${DateTime.parse(ref.watch(transactionProvider).currTrans.date).day.toString()}/${DateTime.parse(ref.watch(transactionProvider).currTrans.date).month.toString()}/${DateTime.parse(ref.watch(transactionProvider).currTrans.date).year.toString()}",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0XFF4F4F4F)
            ),
          ),
        ),
      ],
    ),
  ],)
);

Widget itemsList(WidgetRef ref, int index) => Row(
  mainAxisSize: MainAxisSize.max,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            ref.watch(transactionProvider).currTrans.items[index].name, 
            style: const TextStyle(
              fontSize: 16,
              color: Color(0XFF4F4F4F),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: Rp${ref.watch(transactionProvider).currTrans.items[index].total}"
              ),
              Row(
                children: [
                  Text("${ref.watch(transactionProvider).currTrans.items[index].qty} x"),
                  const SizedBox(width: 36),
                  Text("Rp ${ref.watch(transactionProvider).currTrans.items[index].price}", style: const TextStyle(fontWeight: FontWeight.w700)),
                ]
              ),
            ],
          )
        ),
    ],)
  )],
);

Widget listItems(WidgetRef ref) => ListView.separated(
  shrinkWrap: true,
  padding: const EdgeInsets.only(bottom: 12.0),
  itemCount: ref.watch(transactionProvider).currTrans.items.length,
  itemBuilder: (BuildContext context, int index) {
    return itemsList(ref, index);
  },
  separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
);

Widget summaryItems(WidgetRef ref, String title) => Column(children: [
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, textAlign: TextAlign.left, style: const TextStyle(fontWeight: FontWeight.w600)),
      Text(
        title == "Subtotal"
        ? ref.watch(transactionProvider).currTrans.subtotal.toString()
        : title == "Tax"
          ? ref.watch(transactionProvider).currTrans.tax.toString()
          : ref.watch(transactionProvider).currTrans.service.toString()
        , 
        style: const TextStyle(
          fontWeight: FontWeight.w600
        )
      ),
    ]
  ),
  const SizedBox(height: 12.0)
],); 
