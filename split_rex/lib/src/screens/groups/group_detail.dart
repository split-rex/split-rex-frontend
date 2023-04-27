import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/widgets/group_detail.dart';

import '../../services/group.dart';

class GroupDetail extends ConsumerWidget {
  const GroupDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        onRefresh: () => _pullRefresh(context, ref),
        child: (
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  GroupDetailHeader(
                    group: ref.watch(groupListProvider).currGroup,
                    prevPage: "/group_list",
                  ),
                  Expanded(
                    child: GroupDetailContent(
                      group: ref.watch(groupListProvider).currGroup,
                    ),
                  )
                ],
              )
            )
          )
        )
      )
    );
  }

  Future<void> _pullRefresh(BuildContext context, WidgetRef ref) async {
    GroupServices().getGroupDetail(ref, ref.watch(groupListProvider).currGroup.groupId);
  }
}
