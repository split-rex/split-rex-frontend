
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/routes.dart';

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
      default:
        return const Home();
    }
  }
}