import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/friend.dart';
import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/services/group.dart';
import 'package:split_rex/src/widgets/group_list.dart';

import '../common/functions.dart';
import '../providers/routes.dart';
import '../services/friend.dart';

class UserDetail extends ConsumerWidget {
  const UserDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Initicon(
          text: ref.watch(authProvider).userData.name, 
          size: 55,
          backgroundColor: getProfileBgColor(ref.watch(authProvider).userData.color),
          style: TextStyle(
            color: getProfileTextColor(ref.watch(authProvider).userData.color)
          ),
        ),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Welcome back,",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Text(
            ref.watch(authProvider).userData.name,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 28,
              color: Colors.white,
            ),
          )
        ]),
      ],
    );
  }
}

class FriendRequest extends ConsumerWidget {
  const FriendRequest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    () async {
      FriendServices().friendRequestReceivedList(ref);
    }();
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: const BoxDecoration(
          color: Color(0X25FFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
              flex: 7,
              child: Row(
                children: [
                  const Icon(
                    Icons.group,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8.0),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),

                        // TOOD: connect to backend @samuelswandi
                        // if there is no friend request, show this you have no friend request
                        // if there is friend request, show this you have x friend request

                        children:
                            ref.watch(friendProvider).friendReceivedList.isEmpty
                                ? [
                                    const TextSpan(
                                        text: "You don't have friend request!"),
                                  ]
                                : [
                                    const TextSpan(text: "You have "),
                                    TextSpan(
                                        text: ref
                                            .watch(friendProvider)
                                            .friendReceivedList
                                            .length
                                            .toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700)),
                                    const TextSpan(text: " friend requests!"),
                                  ]),
                  ),
                ],
              )),
          InkWell(
            onTap: () async {
              await FriendServices().friendRequestReceivedList(ref);
              await FriendServices().friendRequestSentList(ref);

              ref.watch(friendProvider).resetAddFriend();
              ref.watch(routeProvider).changePage("friend_requests");
            },
            child: const Text("Review",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                )),
          ),
        ]));
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFF59C4B0),
            Color(0XFF43A7B7),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        padding: const EdgeInsets.only(
            top: 72.0, right: 28.0, left: 28.0, bottom: 40.0),
        child: Column(children: const [
          UserDetail(),
          SizedBox(height: 16),
          FriendRequest()
        ]));
  }
}

class HomeFooter extends ConsumerWidget {
  const HomeFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xFFFFFFFF),
            Color(0XFFE0F2F1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Container(
          margin: const EdgeInsets.only(top: 55.0, left: 28.0, right: 28.0),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0XFFF9F7F7),
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Row(children: [
                  (ref.watch(groupListProvider).isOwed)
                      ? Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                              ref.watch(groupListProvider).changeIsOwed(true);
                              GroupServices().getGroupOwed(ref);
                            },
                            child: Container(
                              // color: Colors.white,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(24.0)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0XFF4F4F4F)
                                          .withOpacity(0.1),
                                      spreadRadius: 0.0,
                                      blurRadius: 5.0,
                                      offset: Offset.zero),
                                ],
                              ),
                              child: const Text(
                                "Owed",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ))
                      : Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                              ref.watch(groupListProvider).changeIsOwed(true);
                              GroupServices().getGroupOwed(ref);
                            },
                            child: Container(
                              // color: Colors.white,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                "Owed",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ),
                          )),
                  (ref.watch(groupListProvider).isOwed)
                      ? Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                              ref.watch(groupListProvider).changeIsOwed(false);
                              GroupServices().getGroupLent(ref);
                            },
                            child: Container(
                              // color: Colors.white,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24.0)),
                              ),
                              child: const Text(
                                "Lent",
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ),
                          ))
                      : Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                              ref.watch(groupListProvider).changeIsOwed(false);
                              GroupServices().getGroupLent(ref);
                            },
                            child: Container(
                              // color: Colors.white,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(24.0)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0XFF4F4F4F)
                                          .withOpacity(0.1),
                                      spreadRadius: 0.0,
                                      blurRadius: 5.0,
                                      offset: Offset.zero),
                                ],
                              ),
                              child: const Text(
                                "Lent",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        )
                ]),
              ),

              searchBar(context, ref),
              Expanded(flex: 5, child: showGroups(context, ref)),
             
            ],
          ),
        ));
  }
}
