import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:split_rex/src/model/friends.dart';
import 'package:split_rex/src/providers/routes.dart';

import '../../common/functions.dart';
import '../../providers/friend.dart';

class AddFriendsSection extends ConsumerWidget {
  const AddFriendsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.watch(friendProvider).resetAddFriend();
        ref.read(routeProvider).changePage("add_friends");
      },
      child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width - 40.0,
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
          child: Row(
            children: const [
              Icon(Icons.group_add),
              SizedBox(width: 10),
              Text(
                "Add Friends",
                style: TextStyle(
                    color: Color(0xFF4F4F4F),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          )),
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
      onTap: () => ref.read(routeProvider).changePage("friend_requests"),
      child: Container(
          height: 72,
          width: MediaQuery.of(context).size.width - 40.0,
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
                  ? const Expanded(
                      child: Text("You don't have any friend requests",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          )))
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
      margin: const EdgeInsets.only(bottom: 24),
      width: MediaQuery.of(context).size.width - 40.0,
      padding: const EdgeInsets.only(top: 25, bottom: 10, left: 20, right: 30),
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
                    index: index,
                  );
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
  const FriendList({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(friendProvider).friendList[index];

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: InkWell(
          onTap: () => friendInfoDialog(context, user),
          child: Row(
            children: [
              Initicon(
                text: user.name,
                size: 40,
                backgroundColor: getProfileBgColor(user.color),
                style: TextStyle(color: getProfileTextColor(user.color)),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(user.name,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4F4F4F)))),
            ],
          ),
        ));
  }
}

friendInfoDialog(context, Friend user) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      child: Container(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: [
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  color: Color(0xFF15808D),
                ),
              )
            ]),
            Row(
              children: [
                Initicon(
                    text: user.name,
                    size: 57,
                    backgroundColor: getProfileBgColor(user.color),
                    style: TextStyle(color: getProfileTextColor(user.color))),
                const SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODO: handle overflow
                    Text(user.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(user.username, style: const TextStyle(fontSize: 14))
                  ],
                )
              ],
            ),
            const Divider(thickness: 1, height: 30.0, color: Color(0xFFE1F3F2)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Payment Info",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5,
                ),
                (user.flattenPaymentInfo.isEmpty)
                    ? const Text("This user does not have any payment info.")
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: user.flattenPaymentInfo.length,
                        itemBuilder: (context, index) {
                          return FriendPaymentInfoDetail(
                            paymentMethod: user.flattenPaymentInfo[index][0],
                            accountNumber: user.flattenPaymentInfo[index][1],
                            accountName: user.flattenPaymentInfo[index][2],
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(
                          height: 5,
                          thickness: 0,
                        ),
                      )
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ),
  );
}

class FriendPaymentInfoDetail extends ConsumerWidget {
  const FriendPaymentInfoDetail({
    super.key,
    required this.paymentMethod,
    required this.accountNumber,
    required this.accountName,
  });

  final String paymentMethod;
  final String accountNumber;
  final String accountName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 210.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(paymentMethod,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("$accountNumber a.n. $accountName"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
