import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';
import 'package:split_rex/src/services/group.dart';

import 'package:split_rex/src/widgets/group_list.dart';
import 'package:split_rex/src/widgets/navbar.dart';

class GroupList extends ConsumerWidget {
  const GroupList({super.key});

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
                "Groups",
                "/",
                Container(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      searchBar(context, ref),
                      Expanded(flex: 5, child: showGroups(context, ref)),
                    ],
                  ),
                ),
              ),
            )
          )
        )
      )
    );
  }

  Future<void> _pullRefresh(BuildContext context, WidgetRef ref) async {
    await GroupServices().userGroupList(ref);
  }
}
