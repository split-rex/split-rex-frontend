import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/add_expense.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../common/formatter.dart';
import '../../services/group.dart';

class DateTimeField extends ConsumerWidget {
  const DateTimeField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        showDialog(
          barrierColor: const Color.fromARGB(82, 0, 0, 0),
          context: context,
          builder: (BuildContext dialogContext) {
            final DateRangePickerController dateController = DateRangePickerController();
            dateController.selectedDate = ref.watch(addExpenseProvider).newBill.date != "" 
            ? DateTime.parse(ref.watch(addExpenseProvider).newBill.date)
            : DateTime.now();
            return Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                width: MediaQuery.of(context).size.width - 60.0,
                height: MediaQuery.of(context).size.height - 275.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    const Text("Select transaction date"),
                    SfDateRangePicker(
                      initialDisplayDate: DateTime.now(),
                      initialSelectedDate: DateTime.now(),
                      controller: dateController,
                      view: DateRangePickerView.month,
                      selectionMode: DateRangePickerSelectionMode.single,
                      onSelectionChanged: (args) {
                        if (ref.watch(addExpenseProvider).isNewGroup) {
                          ref.read(addExpenseProvider).changeBillDate(args.value.toString());
                        }
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(dialogContext);
                      },
                      child:
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: const Color(0XFF2E9281),
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: const Text("Done", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                      ),
                    )
                ])
              )
            );
          }
        );
      },
      child: Card(
        elevation: 2.0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.calendar_month, color: Color.fromARGB(255, 110, 110, 110)),
              const SizedBox(width: 8.0),
              Text(
                ref.watch(addExpenseProvider).newBill.date != "" 
                ? "${DateTime.parse(ref.watch(addExpenseProvider).newBill.date).day}/${DateTime.parse(ref.watch(addExpenseProvider).newBill.date).month}/${DateTime.parse(ref.watch(addExpenseProvider).newBill.date).year}"
                : "${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),
              )
            ]
          )
        )
      ) 
  );
}
}


class ItemCard extends ConsumerStatefulWidget {
  final int index;
  const ItemCard({super.key, required this.index});

  @override
  ConsumerState<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends ConsumerState<ItemCard> {

  @override
  Widget build(BuildContext context) {
    final index = widget.index;
    return Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.read(addExpenseProvider).deleteItem(index);
                    },
                    child: const Icon(
                      Icons.delete, 
                      color: Color(0XFF6DC7BD)
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        onChanged: (val) {
                          ref.read(addExpenseProvider).changeItemQty(index, val);
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
                  ),
                  const Text(" x "),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        onChanged: (val) {
                          ref.read(addExpenseProvider).changeItemPrice(index, val);
                        },
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                          prefixIcon: const Padding(padding: EdgeInsets.all(15), child: Text('IDR ')),
                          hintText: tFormat(ref.watch(addExpenseProvider).items[index].price.toDouble()),
                          filled: true,
                          fillColor: const Color(0XFFF6F6F6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      padding: const EdgeInsets.all(8.0), 
                      alignment: Alignment.centerRight, 
                      child: Text(
                        "Total: ${mFormat(ref.watch(addExpenseProvider).items[index].total.toDouble())}", 
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        )
                      )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );

  }
}

class ListItem extends ConsumerWidget {
  const ListItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: [
      ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: ref.watch(addExpenseProvider).items.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemCard(key: ObjectKey(ref.watch(addExpenseProvider).items[index]), index: index);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
      ),
      const Divider(thickness: 1, height: 28.0, color: Color.fromARGB(30, 79, 79, 79)),
    ]);
  }
}

class AddItem extends ConsumerWidget {
  const AddItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(addExpenseProvider).addEmptyItem();
      },
      child: Row(
        children: const [
          Icon(Icons.add, color: Color(0XFF2E9281)),
          SizedBox(width: 16.0),
          Text("Add Item", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0XFF2E9281)))
        ],
      )
    );
  }
}

class SummaryField extends ConsumerStatefulWidget {
  final String title;
  const SummaryField({super.key, required this.title});

  @override
  ConsumerState<SummaryField> createState() => _SummaryFieldState();
}

class _SummaryFieldState extends ConsumerState<SummaryField> {

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title, textAlign: TextAlign.left, style: const TextStyle(fontWeight: FontWeight.w600)),
          Container(
            width: 150, 
            height: 40,
            padding: EdgeInsets.zero,
            child: 
            widget.title == "Subtotal"
            ? Container(
                padding: const EdgeInsets.only(right: 8.0),
                alignment: Alignment.centerRight,
                child: Text(
                tFormat(ref.watch(addExpenseProvider).newBill.subtotal * 1.0),
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14
                )
              ),
            )
            :
            TextField(
              onChanged: (val) {
                switch (widget.title) {
                  case "Tax":
                    ref.read(addExpenseProvider).changeBillTax(val);
                    break;
                  case "Service charge":
                    ref.read(addExpenseProvider).changeBillService(val);
                    break;
                  default:
                    break;
                }
              },
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
                hintText: widget.title == "Tax"
                ? tFormat(ref.watch(addExpenseProvider).newBill.tax.toDouble())
                : tFormat(ref.watch(addExpenseProvider).newBill.service.toDouble())
                ,
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
  }
}

class ConfirmButton extends ConsumerWidget {
  const ConfirmButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (ref.watch(addExpenseProvider).items.isNotEmpty) {
          if (!ref.watch(addExpenseProvider).isNewGroup) {
            GroupServices().getGroupDetail(ref, ref.watch(addExpenseProvider).existingGroup.groupId).then((value) {
              ref.read(routeProvider).changePage(context, "/split_bill");
            });
          } else {
            ref.read(routeProvider).changePage(context, "/split_bill");
          }
        } else {
          null;
        }
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        height: 72,
        child:
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
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
  }
}