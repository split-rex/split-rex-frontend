
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/screens/account.dart';
import 'package:split_rex/src/screens/activity.dart';
import 'package:split_rex/src/screens/friend_requests.dart';
import 'package:split_rex/src/screens/group_list.dart';

import 'package:split_rex/src/screens/home.dart';
import 'package:split_rex/src/screens/sign_in.dart';
import 'package:split_rex/src/screens/sign_up.dart';

class PageRouting extends ConsumerWidget {
  const PageRouting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentPage = ref.watch(routeProvider).currentPage;

    switch(currentPage) {
      case "sign_up":
        return const SignUpScreen();
      case "sign_in":
        return const SignInScreen();
      case "home":
        return const Home();
      case "group_list":
        return const GroupList();
      case "activity":
        return const Activity();
      case "account":
        return const Account();
  
      // friends
      case "friend_requests":
        return const FriendRequests();

      default:
        return const Home();
    }
  }
}