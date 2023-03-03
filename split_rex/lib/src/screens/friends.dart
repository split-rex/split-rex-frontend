import 'package:flutter/material.dart';
import 'package:split_rex/src/screens/add_friends.dart';
import 'package:split_rex/src/widgets/home.dart';

import '../widgets/friends/friends.dart';

class Friends extends StatelessWidget {
  const Friends({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  const [
        FriendsHeader(),
        SizedBox(height: 15),
        AddFriendsSection(),
        SizedBox(height: 15),
        FriendRequestSection(),
        SizedBox(height: 15),
        // TODO: sort for friends
        FriendsSection()
    ]);
  }
}
