import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/providers/friend.dart';
import 'package:split_rex/src/services/friend.dart';

import '../../common/functions.dart';

class AddFriendSearchSection extends ConsumerWidget {
  const AddFriendSearchSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: TextField(
                  onSubmitted: (value) =>
                      FriendServices().searchUserToAdd(ref, value),
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: 'Search by email, name, or username',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 16),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(15),
                        width: 18,
                        child: const Icon(Icons.search, color: Colors.grey),
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FriendsSearched extends ConsumerWidget {
  const FriendsSearched({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Initicon(
            text: ref.watch(friendProvider).addFriend.name,
            size: 114,
            backgroundColor: getProfileBgColor(ref.watch(friendProvider).addFriend.color),
            style: TextStyle(
              color: getProfileTextColor(ref.watch(friendProvider).addFriend.color)
            ),
        ),
        const SizedBox(height: 10),
        Text(ref.watch(friendProvider).addFriend.name,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4F4F4F))),
        const AddBtn()
      ],
    );
  }
}

class AddBtn extends ConsumerWidget {
  const AddBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var errorType = ref.watch(errorProvider).errorType;
    var errorMsg = ref.watch(errorProvider).errorMsg;

    if (errorType == "ERROR_CANNOT_ADD_SELF" ||
        errorType == "ERROR_ALREADY_FRIEND" ||
        errorType == "ERROR_USER_NOT_FOUND" ||
        errorType == "ERROR_ALREADY_REQUESTED_SENT" ||
        errorType == "ERROR_ALREADY_REQUESTED_RECEIVED") {
      return Text(errorMsg);
    }

    return GestureDetector(
      onTap: () async {
        await FriendServices()
            .addFriend(ref, ref.watch(friendProvider).addFriend.userId).then((value) async {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
              padding: const EdgeInsets.all(16),
              height: 70,
              decoration: const BoxDecoration(
                  color: Color(0xFF6DC7BD),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Friend request sent!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ));
          await Future.delayed(const Duration(seconds: 4));
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: 36,
        width: 88,
        decoration: BoxDecoration(
          color: const Color(0xFF6DC7BD),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xffEEEEEE)),
          ],
        ),
        child: const Text(
          "Add",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
