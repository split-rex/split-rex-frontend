import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';
import 'package:split_rex/src/widgets/activity.dart';
import 'package:split_rex/src/widgets/navbar.dart';


class Activity extends ConsumerWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const Navbar(),
      body: header(
        context,
        ref,
        "Activity", 
        "/",
        Container(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(children: [Expanded(flex: 5, child: activityListWidget(context, ref)),],)
        ),
      ),
    );
  }
}
