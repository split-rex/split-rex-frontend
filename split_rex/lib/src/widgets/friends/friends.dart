import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:split_rex/src/providers/routes.dart';

import '../../providers/friend.dart';

class AddFriendsSection extends ConsumerWidget {
  const AddFriendsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.watch(routeProvider).changePage("add_friends"),
      child: Container(
        height: 60,
        width: 348,
        padding: const EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 0), // Shadow position
            ),
          ],
        ),
        child: const Text(
          "Add Friends",
          style: TextStyle(
              color: Color(0xFF4F4F4F),
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }
}

class FriendRequestSection extends ConsumerWidget {
  const FriendRequestSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String generateFriendRequests() {
      List<String> friendRequestString = <String>[];

      for (var friend in ref.watch(friendProvider).friendReceivedList) {
        friendRequestString.add(friend.name);
      }

      return friendRequestString.join(", ");
    }

    return InkWell(
      onTap: () => ref.watch(routeProvider).changePage("friend_requests"),
      child: Container(
          height: 72,
          width: 348,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 0), // Shadow position
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              (ref.watch(friendProvider).friendReceivedList.isEmpty)
                  ? const Text("You don't have any friend requests",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ))
                  : Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Friend Requests (${ref.watch(friendProvider).friendReceivedList.length})",
                            style: const TextStyle(
                                color: Color(0xFF4F4F4F), fontSize: 12),
                          ),
                          Flexible(
                            child: Text(
                              generateFriendRequests(),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 24),
            ],
          )),
    );
  }
}

class FriendsSection extends ConsumerWidget {
  const FriendsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 348,
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ref.watch(friendProvider).friendList.isEmpty
              ? const Text("You don't have any friend at the moment")
              : Text(
                  "Friends (${ref.watch(friendProvider).friendList.length})",
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListView.separated(
                itemCount: ref.watch(friendProvider).friendList.length,
                padding: const EdgeInsets.only(top: 12),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return FriendList(
                      name: ref.watch(friendProvider).friendList[index].name);
                },
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  indent: 20,
                  color: Color(0xFFE1F3F2),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FriendList extends ConsumerWidget {
  const FriendList({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Initicon(text: name, size: 40),
          Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4F4F4F)))),
        ],
      ),
    );
  }
}
