import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/group_model.dart';
import 'package:split_rex/src/widgets/group_detail.dart';

class GroupDetail extends ConsumerWidget {
  const GroupDetail({super.key, required this.group});

  final GroupListModel group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
          children: [
            GroupDetailHeader(group: group),
            Expanded(
              child: GroupDetailContent(group: group,),
            )
          ],
        );
  }
}
