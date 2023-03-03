import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/header.dart';
import '../widgets/friends/add_friends.dart';

class AddFriends extends ConsumerWidget {
  const AddFriends({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
      context,
      ref,
      "Add Friend",
      "friends",
      Column(
        children: const [
          AddFriendSearchSection(),
          Center(heightFactor: 2, child: FriendsSearched()),
        ],
      ),
    );

    // return Column(
    //   children:  const [
    //     AddFriendHeader(),
    //     AddFriendSearchSection(),
    //     Center(
    //       heightFactor: 2,
    //       child: FriendsSearched()
    //     ),
    //     ],
    // );
  }
}
