import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/widgets/group_detail.dart';

class GroupDetail extends ConsumerWidget {
  const GroupDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupListProvider).currGroup;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          GroupDetailHeader(
            group: group,
            prevPage: "group_list",
          ),
          Expanded(
            child: GroupDetailContent(
              group: group,
            ),
          )
        ],
      ),
    );
  }
}
