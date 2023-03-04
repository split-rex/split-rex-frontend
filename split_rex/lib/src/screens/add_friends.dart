import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/providers/friend.dart';

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
        children: [
          const AddFriendSearchSection(),
          (ref.watch(friendProvider).addFriend.name.isEmpty)
              ? (ref.watch(errorProvider).errorMsg.isNotEmpty)
                  ? Text(ref.watch(errorProvider).errorMsg)
                  : const SizedBox(
                      height: 0,
                    )
              : const Center(heightFactor: 2, child: FriendsSearched()),
        ],
      ),
    );
  }
}
