import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/services/friend.dart';
import '../../common/functions.dart';
import '../../providers/friend.dart';
import '../../providers/routes.dart';
import 'friends.dart';

class FriendRequestSelector extends ConsumerWidget {
  const FriendRequestSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
        length: 1,
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  ref.read(routeProvider).changePage(context, "/");
                },
                color: const Color(0xFF4F4F4F),
              ),
              const Center(
                widthFactor: 2,
                child: Text(
                  "Friend Requests",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF4F4F4F),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class FriendRequestSectionPicker extends ConsumerWidget {
  const FriendRequestSectionPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        margin: const EdgeInsets.only(left: 28.0, right: 28.0),
        width: MediaQuery.of(context).size.width - 40.0,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              (ref.watch(friendProvider).isReceived)
                  ? InkWell(
                      onTap: () =>
                          ref.watch(friendProvider).changeIsReceived(true),
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Color(0xFF4F9A99),
                          width: 3.0,
                        ))),
                        child: const Text(
                          "Received",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF4F9A99),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () =>
                          ref.watch(friendProvider).changeIsReceived(true),
                      child: const Text("Received",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF4F4F4F),
                              fontWeight: FontWeight.w500))),
              (!ref.watch(friendProvider).isReceived)
                  ? InkWell(
                      onTap: () =>
                          ref.watch(friendProvider).changeIsReceived(false),
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Color(0xFF4F9A99),
                          width: 3.0,
                        ))),
                        child: const Text(
                          "Sent",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF4F9A99),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () =>
                          ref.watch(friendProvider).changeIsReceived(false),
                      child: const Text("Sent",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF4F4F4F),
                              fontWeight: FontWeight.w500))),
            ]));
  }
}

class FriendRequestsBody extends ConsumerWidget {
  const FriendRequestsBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        margin: const EdgeInsets.only(left: 28.0, right: 28.0),
        width: MediaQuery.of(context).size.width - 40.0,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
        child: (ref.watch(friendProvider).isReceived)
            ? (ref.watch(friendProvider).friendReceivedList.isEmpty)
                ? Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text("You don't have any friend requests",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF4F4F4F))),
                  )
                : ListView.separated(
                    itemCount:
                        ref.watch(friendProvider).friendReceivedList.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 12),
                    itemBuilder: (context, index) {
                      return FriendRequestDetail(
                          name: ref
                              .watch(friendProvider)
                              .friendReceivedList[index]
                              .name,
                          userId: ref
                              .watch(friendProvider)
                              .friendReceivedList[index]
                              .userId,
                          color: ref
                              .watch(friendProvider)
                              .friendReceivedList[index]
                              .color);
                    },
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                      indent: 20,
                      color: Color(0xFFE1F3F2),
                    ),
                  )
            : (ref.watch(friendProvider).friendSentList.isEmpty)
                ? Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text("You don't have any friend requests",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF4F4F4F))),
                  )
                : ListView.separated(
                    itemCount: ref.watch(friendProvider).friendSentList.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 15, top: 12),
                    itemBuilder: (context, index) {
                      return FriendList(user: ref.watch(friendProvider).friendSentList[index]);
                    },
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                      indent: 20,
                      color: Color(0xFFE1F3F2),
                    ),
                  ));
  }
}

class FriendRequestDetail extends ConsumerWidget {
  const FriendRequestDetail(
      {super.key,
      required this.name,
      required this.userId,
      required this.color});

  final String name;
  final String userId;
  final int color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width - 40.0,
      color: const Color(0xFFffffff),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: Initicon(
                text: name,
                backgroundColor: getProfileBgColor(color),
                style: TextStyle(color: getProfileTextColor(color)),
              ),
            ),
            const SizedBox(width: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 19.0,
                      color: Color(0xFF4F4F4F),
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Row(children: [
                  InkWell(
                    onTap: () async =>
                        await FriendServices().rejectFriendRequest(ref, userId),
                    child: Container(
                      alignment: Alignment.center,
                      width: 117,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFFDFF2F0),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: const Text(
                        "Reject",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2E9281),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () async {
                      await FriendServices().acceptFriendRequest(ref, userId);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 117,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF6DC7BD),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: const Text(
                        "Accept",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            )
          ]),
    );
  }
}
