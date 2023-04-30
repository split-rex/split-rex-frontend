import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/header.dart';
import '../../providers/friend.dart';
import '../../services/friend.dart';
import '../../widgets/friends/friend_request.dart';


class FriendRequests extends ConsumerWidget {
  const FriendRequests({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: header(
        context,
        ref,
        "Friend Requests",
        "/friends",
        RefreshIndicator(
        onRefresh: () => _pullRefresh(context, ref),
        child: (
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 120,
              child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      FriendRequestSectionPicker(), // change to appbar
                      SizedBox(height: 18),
                      FriendRequestsBody(),
                    ],
                  )
                )
              )
            )
          )
        )
      )
    );
  }

  Future<void> _pullRefresh(BuildContext context, WidgetRef ref) async {
    await FriendServices().friendRequestReceivedList(ref).then((value) {
      FriendServices().friendRequestSentList(ref).then((value) {
        ref.watch(friendProvider).resetAddFriend();
      });
    });
  }
}
