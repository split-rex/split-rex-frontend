import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';

import 'package:split_rex/src/widgets/expense/add_expense.dart';

class AddExpense extends ConsumerWidget {
  const AddExpense({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: header(
        context, 
        ref,
        "Add Expense",
        "/home",
        Container(
          padding: const EdgeInsets.only(top: 8.0),
          child: 
          Column(
            children: [
              searchBar(ref),
              Expanded(
                flex: 5, 
                child: addExistingGroup(context, ref)
              ),
              Expanded(
                flex: 7, 
                child: addNewGroup(context, ref)
              ),
              addButton(ref, context)                
            ],
          ),
        )
      ),
    );
  }
}
