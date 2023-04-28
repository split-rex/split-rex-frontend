import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/widgets/choose_friend.dart';

import '../../common/header.dart';
import '../../services/friend.dart';
import '../../widgets/friends/friends.dart';

class Friends extends ConsumerWidget {
  const Friends({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        onRefresh: () => _pullRefresh(context, ref),
        child: (
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: header(
                context,
                ref,
                "Friends",
                "/group_list",
                Container(
                  padding: const EdgeInsets.only(top: 8.0),
                  child:Column(
                    children: [
                      const SizedBox(height: 15),
                      const AddFriendsSection(),
                      const SizedBox(height: 15),
                      const FriendRequestSection(),
                      const SizedBox(height: 15),
                      searchBar(context, ref),
                      const SizedBox(height: 15),
                      // TODO: sort for friends
                      // FriendsSection(),
                      const Expanded(
                        flex: 7,
                        child: FriendsSection(),
                      )
                    ],
                  )
                )
              ),
            )
          )
        )
      )
    );
  }

  Future<void> _pullRefresh(BuildContext context, WidgetRef ref) async {
    await FriendServices().userFriendList(ref).then((value) {
      FriendServices().friendRequestReceivedList(ref).then((value) {
        FriendServices().friendRequestSentList(ref);
      });
    });
  }
}
