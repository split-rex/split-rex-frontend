import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/group_model.dart';
import 'package:split_rex/src/widgets/groups/group_settings.dart';

import '../../common/header.dart';

class GroupSettings extends ConsumerWidget {
  const GroupSettings({super.key, required this.group});

  final GroupListModel group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
      context,
      ref,
      "Group Settings", 
      "group_detail",
      Column(
          children: const [
            AddGroupMembersSection(),
            SizedBox(height: 15),
            GroupMembers(),
          ],
        )
    );
  }
}
