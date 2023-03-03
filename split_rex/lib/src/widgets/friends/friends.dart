import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:split_rex/src/providers/routes.dart';

class AddFriendsSection extends ConsumerWidget {
  const AddFriendsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      // onTap: // change to add screen,
      onTap: () => ref.watch(routeProvider).changePage("add_friends"),
      child: Container(
        height: 60,
        width: 348,
        padding: const EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
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
    return InkWell(
      onTap: () => ref.watch(routeProvider).changePage("friend_requests"),
      child: Container(
          height: 72,
          width: 348,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                // TODO: make it dynamic
                "Friend Requests (5)",
                style: TextStyle(color: Color(0xFF4F4F4F), fontSize: 12),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    // TODO: make it dynamic
                    "Francesco Parrino, Lorem, lorem...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_rounded, size: 24),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // ref.watch(routeProvider).changePage("home");
                    },
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class FriendsSection extends StatefulWidget {
  const FriendsSection({super.key});
  @override
  _FriendsSection createState() => new _FriendsSection();
}

class _FriendsSection extends State<FriendsSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 348,
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 30),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            // TODO: make it dynamic
            "Friends (5)",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              FriendList(),
              Divider(
                thickness: 1,
                indent: 20,
                color: Color(0xFFE1F3F2),
              ),
              FriendList(),
              Divider(
                thickness: 1,
                indent: 20,
                color: Color(0xFFE1F3F2),
              ),
              FriendList()
            ],
          )
        ],
      ),
    );
  }
}

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  State<FriendList> createState() => _FriendList();
}

class _FriendList extends State<FriendList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          const Initicon(text: "Francesco Parrino", size: 40),
          Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text("Francesco Parrino",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4F4F4F)))),
        ],
      ),
    );
  }
}
