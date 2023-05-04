import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/logger.dart';
import 'package:split_rex/src/services/statistics.dart';
import 'package:split_rex/src/widgets/navbar.dart';
import '../providers/auth.dart';
import '../services/friend.dart';
import '../services/group.dart';
import '../services/scheduled_notification.dart';
import '../widgets/home.dart';

Timer makePeriodicTimer(
  Duration duration,
  void Function(Timer timer) callback, {
  bool fireNow = false,
}) {
  var timer = Timer.periodic(duration, callback);
  if (fireNow) {
    callback(timer);
  }
  return timer;
}

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  Timer? _timer;

    @override
    void initState() {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        _timer = makePeriodicTimer(
          const Duration(minutes: 30), 
          (Timer t) {
            ScheduledNotificationServices().getScheduledNotification(ref.watch(authProvider).jwtToken);
            logger.d("init Home lgi");
          }, 
          fireNow: true
        );
      });
    }

    @override
    void dispose() {
      logger.d("dispos HOME");
      _timer?.cancel();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
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
    await StatisticsServices().owedLentPercentage(ref).then((value) {
      GroupServices().userGroupList(ref).then((value) {
        FriendServices().userFriendList(ref).then((value) {
          FriendServices().friendRequestReceivedList(ref).then((value) {
            FriendServices().friendRequestSentList(ref).then((value) {
              getGroupOwedLent(ref);
            });
          });
        });
      });
    });
  }
}
