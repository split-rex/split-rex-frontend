import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/add_expense.dart';
import 'package:split_rex/src/providers/routes.dart';

Widget dateTimeField(WidgetRef ref) => TextField(
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
);

Widget itemCard(WidgetRef ref, int index) => Row(
  children: [
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 340,
          margin: const EdgeInsets.only(bottom: 8.0),
          child: 
            TextField(
              onChanged: (val) {
                ref.read(addExpenseProvider).changeItemName(index, val);
              },
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                hintText: ref.watch(addExpenseProvider).items[index].name,
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
                width: 65,
                margin: const EdgeInsets.only(left: 8.0),
                child: 
                TextField(
                  onChanged: (val) {
                    ref.read(addExpenseProvider).changeItemQty(index, int.parse(val));
                  },
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    hintText: "${ref.watch(addExpenseProvider).items[index].qty}",
                    filled: true,
                    fillColor: const Color(0XFFF6F6F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none
                    ),
                  ),
                ), 
              ),
              const Text(" x "),
              Container(
                width: 150, 
                margin: const EdgeInsets.only(left: 8.0),
                child: 
                TextField(
                  onChanged: (val) {
                    ref.read(addExpenseProvider).changeItemPrice(index, int.parse(val));
                  },
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                    prefixIcon: const Padding(padding: EdgeInsets.all(15), child: Text('Rp ')),
                    hintText: "${ref.watch(addExpenseProvider).items[index].price}",
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

Widget listItem(WidgetRef ref) => ListView.separated(
  shrinkWrap: true,
  padding: const EdgeInsets.symmetric(vertical: 8.0),
  itemCount: ref.watch(addExpenseProvider).items.length,
  itemBuilder: (BuildContext context, int index) {
    return itemCard(ref, index);
  },
  separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
);

Widget addItem(WidgetRef ref) => InkWell(
  onTap: () {
    ref.read(addExpenseProvider).addItem();
  },
  child: Row(
    children: const [
      Icon(Icons.add, color: Color(0XFF2E9281)),
      SizedBox(width: 16.0),
      Text("Add Item", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0XFF2E9281)))
    ],
  )
);

Widget summaryField(String title) => Column(children: [
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, textAlign: TextAlign.left, style: const TextStyle(fontWeight: FontWeight.w600)),
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
  const SizedBox(height: 8.0)
],);

Widget confirmButton(WidgetRef ref) => GestureDetector(
  onTap: () {
    ref.watch(addExpenseProvider).items.isNotEmpty ?
    ref.watch(routeProvider).changePage("split_bill") : 
    null;
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
          color: ref.watch(addExpenseProvider).items.isNotEmpty ? const Color(0XFF6DC7BD) : const Color.fromARGB(50, 79, 79, 79),
        ),
        child: const Text("Confirm", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))
      )
    )
  )
);