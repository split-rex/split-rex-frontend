import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/header.dart';
import '../../widgets/friends/friend_request.dart';


class FriendRequests extends ConsumerWidget {
  const FriendRequests({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
        context,
        ref,
        "Friend Requests",
        "friends",
        Column(
          children: const [
            FriendRequestSectionPicker(), // change to appbar
            SizedBox(height: 18),
            FriendRequestsBody(),
          ],
        ));
  }
}
