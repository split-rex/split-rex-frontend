import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/widgets/navbar.dart';
import '../services/friend.dart';
import '../services/group.dart';
import '../widgets/home.dart';


class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const Navbar(),
      body: RefreshIndicator(
        onRefresh: () => _pullRefresh(context, ref),
        child: (
          SingleChildScrollView(
            key: UniqueKey(),
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                kBottomNavigationBarHeight + 10,
              child: Column(
                children: const [
                  HomeHeader(),
                  Expanded(
                    child: 
                      HomeFooter()
                  )
                ],
              )
            )
          )
        ),
      )
    );
  }

  Future<void> _pullRefresh(BuildContext context, WidgetRef ref) async {
    await GroupServices().userGroupList(ref).then((value) {
      FriendServices().userFriendList(ref).then((value) {
        FriendServices().friendRequestReceivedList(ref).then((value) {
          FriendServices().friendRequestSentList(ref).then((value) {
            getGroupOwedLent(ref);
          });
        });
      });
    });
  }
}
