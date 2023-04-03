import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';

import '../../widgets/choose_friend.dart';

class ChooseFriend extends ConsumerWidget {
  const ChooseFriend({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
        context,
        ref,
        "Choose Friends",
        "group_detail",
        Container(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              searchBar(context, ref),
              Expanded(flex: 7, child: addFriendToGroup(context, ref)),
            ],
          ),
        ));
  }
}

class ChooseFriendInGroupSetting extends ConsumerWidget {
  const ChooseFriendInGroupSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
        context,
        ref,
        "Choose Friends",
        "group_settings",
        Container(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              searchBarInSettings(context, ref),
              Expanded(flex: 7, child: addFriendToGroup(context, ref)),
              addFriendToGroupButton(ref),
            ],
          ),
        ));
  }
}

