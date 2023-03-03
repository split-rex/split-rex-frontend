import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/routes.dart';
import '../widgets/auth.dart';


class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SignInForm(),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?  "),
                GestureDetector(
                  child: const Text(
                    "Sign up here",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                    ),
                  ),
                  onTap: () {
                    // Write Tap Code Here.
                    ref.read(routeProvider).changePage("sign_up");
                  },
                )
              ],
            ),
          )
        ],
      )
    );
  }
}// bismillah