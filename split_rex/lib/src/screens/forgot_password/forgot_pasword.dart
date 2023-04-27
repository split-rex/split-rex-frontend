import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:split_rex/src/providers/password.dart';
import 'package:split_rex/src/providers/routes.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/header.dart';
import '../../services/password.dart';

class ForgotPassword extends ConsumerWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController emailController = TextEditingController();
    ref.watch(forgotPasswordProvider).timerStopped = false;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: header(
        context,
        ref,
        "Forgot Password",
        "/sign_in",
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
                "Please input your registered e-mail",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Text(
                "to reset your password.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              FormFill(
                controller: emailController,
                key: UniqueKey(),
                icon: Icons.email,
                placeholderText: "E-mail",
              ),
              const SizedBox(height: 10),
              ResetButton(
                emailController: emailController,
                key: UniqueKey(),
              ),
            ],
          )
        ),
      )
    );
  }
}

class FormFill extends ConsumerWidget {
  final String placeholderText;
  final IconData icon;
  final TextEditingController controller;

  const FormFill(
      {required Key key,
      required this.placeholderText,
      required this.icon,
      required this.controller})
      : super(key: key);

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
              color: Color(0xffEEEEEE),
            ),
          ],
          border: Border.all(color: const Color(0xffEEEEEE))),
      child: TextField(
        key: key,
        controller: controller,
        cursorColor: const Color(0xFF59C4B0),
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: const Color(0xFF59C4B0),
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

class ResetButton extends ConsumerWidget {
  final TextEditingController emailController;

  const ResetButton({
    required Key key,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        EasyLoading.instance
          ..displayDuration = const Duration(seconds: 3)
          ..indicatorType = EasyLoadingIndicatorType.fadingCircle
          ..loadingStyle = EasyLoadingStyle.custom
          ..indicatorSize = 45.0
          ..radius = 16.0
          ..textColor = Colors.white
          ..progressColor = const Color(0xFF4F9A99)
          ..backgroundColor = const Color(0xFF4F9A99)
          ..indicatorColor = Colors.white
          ..maskType = EasyLoadingMaskType.custom
          ..maskColor = const Color.fromARGB(155, 255, 255, 255);
        EasyLoading.show(
            status: 'Loading...', maskType: EasyLoadingMaskType.custom);
        await ForgotPassServices().generatePassToken(ref, emailController.text).then((value) {
          ref.watch(forgotPasswordProvider).changeEmail(emailController.text);
          ref.read(routeProvider).changePage(context, "/verify_token");
        });
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
            "Reset my password",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          )),
    );
  }
}
