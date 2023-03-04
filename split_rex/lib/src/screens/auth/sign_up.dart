import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/widgets/auth.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SignUpForm(),
          Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Have an account?  "),
                  GestureDetector(
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                    ),
                  ),
                  onTap: () {
                    ref.read(routeProvider).changePage("sign_in");
                  },
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
