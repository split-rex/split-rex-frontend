import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../providers/add_expense.dart';
import '../../providers/auth.dart';


class CreateNewGroup extends ConsumerStatefulWidget {
  const CreateNewGroup({super.key});

  @override
  ConsumerState<CreateNewGroup> createState() => _CreateNewGroupState();
}

class _CreateNewGroupState extends ConsumerState<CreateNewGroup> {
  final nameController = TextEditingController();
  final dateController = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    var initStartDate = 
      ref.watch(addExpenseProvider).newGroup.startDate != "" 
      ? DateTime.parse(ref.watch(addExpenseProvider).newGroup.startDate)
      : DateTime.now();
    var initEndDate = 
      ref.watch(addExpenseProvider).newGroup.endDate != "" 
      ? DateTime.parse(ref.watch(addExpenseProvider).newGroup.endDate)
      : initStartDate.add(const Duration(days: 3));
    dateController.selectedRange = PickerDateRange(initStartDate, initEndDate);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: header(
        context, 
        ref,
        "Create New Group",
        "/add_expense",
        SingleChildScrollView(
          child:
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
            ),
            width: double.infinity,
            child: Column(
              children:[
                Container(
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0))
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Group Name",
                            style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4F4F4F),
                          )),
                          const SizedBox(height: 8.0,),
                          TextField(
                            key: UniqueKey(),
                            controller: nameController,
                            cursorColor: const Color(0xFF59C4B0),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              filled: true,
                              hintText: ref.watch(addExpenseProvider).newGroup.name,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              suffixIcon: const Icon(Icons.edit, color: Colors.grey)
                            )
                          ),
                          const SizedBox(height: 24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Select start and end date",
                                style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4F4F4F),
                              )),
                              const SizedBox(height: 8.0),
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  width: MediaQuery.of(context).size.width - 60.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child:
                                    SfDateRangePicker(
                                      controller: dateController,
                                      view: DateRangePickerView.month,
                                      selectionMode: DateRangePickerSelectionMode.range,
                                  ),
                                )
                              ),
                            ],
                          ),
                          NextButton(key: UniqueKey(), nameController: nameController, dateController: dateController),
                        ],
                      ),
                    ]
                  )
                ),
              ]
            )
          ),
        )
      ),
    );
  }
}

class NextButton extends ConsumerWidget {
  final TextEditingController nameController;
  final DateRangePickerController dateController;

  const NextButton({
    required Key key,
    required this.nameController,
    required this.dateController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
    onTap: () async {
      if (nameController.text != "") {
        ref.read(addExpenseProvider).changeNewGroupName(nameController.text);
      }
      ref.read(addExpenseProvider).changeNewGroupStartDate(dateController.selectedRange?.startDate.toString());
      ref.read(addExpenseProvider).changeNewGroupEndDate(
        dateController.selectedRange?.endDate == null 
        ? dateController.selectedRange?.startDate.toString()
        : dateController.selectedRange?.endDate.toString()
      );
      ref.read(addExpenseProvider).selectedMember = (ref.watch(authProvider).userData.userId);
      ref.read(routeProvider).changePage(context, "/edit_items");
    },
    child: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Color(0XFF6DC7BD),
          ),
          child: const Text("Next", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))
        )
    );
  }
}