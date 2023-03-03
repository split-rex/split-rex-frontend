import 'package:flutter/material.dart';

import '../widgets/friends/add_friends.dart';

class AddFriends extends StatelessWidget {
  const AddFriends({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  const [
        AddFriendHeader(),
        AddFriendSearchSection(),
        Center(
          heightFactor: 2,
          child: FriendsSearched()
        ),
        ],
    );
  }
}
