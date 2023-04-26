import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/header.dart';
import '../../providers/auth.dart';
import '../../providers/password.dart';
import '../../providers/routes.dart';

bool timerStart = false;

class VerifyToken extends ConsumerWidget {
  const VerifyToken({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    timerStart = false;
    TextEditingController controller = TextEditingController();

    return header(
      context,
      ref,
      "Verification",
      "forgot_password",
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
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
              const SizedBox(height: 30),
              const Text(
                "A password reset email has been sent to",
              ),
              Text(
                ref.watch(forgotPasswordProvider).email,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const Text("If it exists in our system"),
              TokenFormField(
                controller: controller,
                key: UniqueKey(),
                placeholderText: 'Enter code here',
              ),
              const SizedBox(height: 10),
              const TokenTimer(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(fontSize: 11),
                  ),
                  GestureDetector(
                      child: const Text(
                    "Resend code",
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  )),
                  const Text(
                    " or ",
                    style: TextStyle(fontSize: 11),
                  ),
                  GestureDetector(
                    onTap: () =>
                        ref.read(routeProvider).changePage("forgot_password"),
                    child: const Text("Re-enter email",
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              ref.watch(forgotPasswordProvider).timerStopped
                  ? const DisabledResetButton()
                  : ResetButton(
                      codeController: controller,
                      key: UniqueKey(),
                    ),
            ],
          )),
    );
  }
}

class TokenFormField extends ConsumerWidget {
  final TextEditingController controller;
  final String placeholderText;
  const TokenFormField({
    required Key key,
    required this.controller,
    required this.placeholderText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 17),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 56,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xffEEEEEE)),
          ],
          border: Border.all(color: const Color(0xffEEEEEE))),
      child: TextField(
        key: key,
        cursorColor: const Color(0xFF59C4B0),
        decoration: InputDecoration(
            icon: const Icon(
              Icons.lock,
              color: Color(0xFF59C4B0),
            ),
            suffix: InkWell(
              onTap: () {
                ref.read(authProvider).changeVisibility();
              },
              child: Icon(
                ref.watch(authProvider).isVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
            ),
            hintText: placeholderText,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintStyle: const TextStyle(
              fontSize: 14,
            )),
      ),
    );
  }
}

class TokenTimer extends ConsumerStatefulWidget {
  const TokenTimer({Key? key}) : super(key: key);

  @override
  ConsumerState<TokenTimer> createState() => _TokenTimerState();
}

class _TokenTimerState extends ConsumerState<TokenTimer> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 2);

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    if (mounted) {
      setState(() {
        final seconds = myDuration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          countdownTimer!.cancel();
          ref.read(forgotPasswordProvider).changeTimerStopped(true);
        } else {
          myDuration = Duration(seconds: seconds);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    if (!timerStart) {
      startTimer();
      timerStart = true;
    }

    return ref.watch(forgotPasswordProvider).timerStopped
        ? const Text(
            "00:00",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        : Text(
            "$minutes:$seconds",
            style: const TextStyle(fontWeight: FontWeight.bold),
          );
  }
}

class DisabledResetButton extends ConsumerWidget {
  const DisabledResetButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 17),
        height: 56,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0XFFDFF2F0),
        ),
        child: const Text(
          "Verify code",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ));
  }
}

class ResetButton extends ConsumerWidget {
  final TextEditingController codeController;

  const ResetButton({
    required Key key,
    required this.codeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(routeProvider).changePage("create_password");
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
            "Verify code",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          )),
    );
  }
}
