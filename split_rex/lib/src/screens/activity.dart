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
      body: RefreshIndicator(
        onRefresh: () => _pullRefresh(context, ref),
        child: (
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kBottomNavigationBarHeight + 10,
              child: header(
                context,
                ref,
                "Activity", 
                "/home",
                Container(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(children: [Expanded(flex: 5, child: activityListWidget(context, ref)),],)
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
