import 'package:flutter/material.dart';

import '../widgets/friends/friend_request.dart';

class FriendRequests extends StatelessWidget {
  const FriendRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        FriendRequestsHeader(), 
        // TODO: add received and sent section
        // FriendRequestSelector(),
        FriendRequestSectionPicker(), // change to appbar
        SizedBox(height: 18),
        FriendRequestsBody(),
        ],
    );
  }
}
