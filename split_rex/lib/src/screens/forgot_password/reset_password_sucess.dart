import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/error.dart';

import 'package:split_rex/src/providers/routes.dart';

class ResetPassSuccess extends ConsumerWidget {
  const ResetPassSuccess({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(errorProvider).changeError("");
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: const Color(0xFFf4f4f4),
                ),
                child: const Icon(
                  Icons.lock,
                  color: Color(0xFFb4b4b4),
                  size: 40,
                )),
            const SizedBox(height: 40),
            const Text(
              "Password reset successful!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "You can now use the new password to sign in to your account.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            SignInButton(
              key: UniqueKey(),
            ),
          ],
        ));
  }
}

class SignInButton extends ConsumerWidget {
  // final TextEditingController nameController;

  const SignInButton({
    required Key key,
    // required this.nameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        ref.read(routeProvider).changePage("sign_in");
      },
      child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(left: 20, right: 20, top: 17),
          height: 56,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color(0XFF6DC7BD),
          ),
          child: const Text(
            "Sign In",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          )),
    );
  }
}
