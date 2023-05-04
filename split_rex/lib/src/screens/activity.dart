import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';
import 'package:split_rex/src/widgets/activity.dart';
import 'package:split_rex/src/widgets/navbar.dart';

import '../services/activity.dart';


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
        "/home",
        RefreshIndicator(
          onRefresh: () => _pullRefresh(context, ref),
          child: (
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
                child: Container(
                  width: double.infinity,
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Expanded(flex: 5, child: activityListWidget(context, ref)),],)
                  ),
                ),
              )
            )
          )
      )
    );
  }

  Future<void> _pullRefresh(BuildContext context, WidgetRef ref) async {
    await ActivityServices().getActivity(ref);
  }
}
