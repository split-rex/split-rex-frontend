import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';

import 'package:split_rex/src/widgets/group_list.dart';
import 'package:split_rex/src/widgets/navbar.dart';

class GroupList extends ConsumerWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const Navbar(),
      body: header(
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
    );
  }
}
