import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/header.dart';
import '../widgets/friends/friends.dart';

class Friends extends ConsumerWidget {
  const Friends({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return header(
      context, 
      ref, 
      "Friends",
      "group_list",
      Column(children: const [
        SizedBox(height: 15),
        AddFriendsSection(),
        SizedBox(height: 15),
        FriendRequestSection(),
        SizedBox(height: 15),
        // TODO: sort for friends
        FriendsSection()
      ],)
    );
  }
}
