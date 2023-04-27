import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/providers/auth.dart';

import '../../common/header.dart';
import '../../services/password.dart';

class CreateNewPassword extends ConsumerWidget {
  const CreateNewPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController passController = TextEditingController();
    TextEditingController confPassController = TextEditingController();

    return header(
      context,
      ref,
      "Create a New Password",
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
                "Please input your new password.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              PasswordField(
                controller: passController,
                key: UniqueKey(),
                placeholderText: 'Password',
              ),
              PasswordField(
                controller: confPassController,
                key: UniqueKey(),
                placeholderText: 'Confirm Password',
              ),
              const SizedBox(height: 10),
              ResetButton(
                passController: passController,
                confPassController: confPassController,
                key: UniqueKey(),
              ),
            ],
          )),
    );
  }
}

class PasswordField extends ConsumerWidget {
  final TextEditingController controller;
  final String placeholderText;
  const PasswordField({
    required Key key,
    required this.controller,
    required this.placeholderText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordVisible = ref.watch(authProvider).isVisible;
    // print(passwordVisible);
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
          border: Border.all(
              color: Color((ref.watch(errorProvider).errorType ==
                              "ERROR: INVALID USERNAME OR PASSWORD" &&
                          placeholderText == "Password") ||
                      (ref.watch(errorProvider).errorType ==
                              "ERROR_PASSWORD_AND_CONFIRMATION_NOT_MATCH" &&
                          placeholderText == "Password") ||
                      (ref.watch(errorProvider).errorType ==
                              "ERROR_PASSWORD_AND_CONFIRMATION_NOT_MATCH" &&
                          placeholderText == "Confirm Password")
                  ? 0xFFF44336
                  : 0xffEEEEEE))),
      child: TextField(
        key: key,
        obscureText: passwordVisible,
        controller: controller,
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

class ResetButton extends ConsumerWidget {
  final TextEditingController passController;
  final TextEditingController confPassController;
  const ResetButton({
    required Key key,
    required this.passController,
    required this.confPassController,
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
        await ForgotPassServices()
            .changePasword(ref, passController.text, confPassController.text);

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
            padding: const EdgeInsets.all(16),
            height: 70,
            decoration: BoxDecoration(
                color: Color(ref.watch(errorProvider).errorType ==
                            "ERROR_PASSWORD_AND_CONFIRMATION_NOT_MATCH" ||
                        ref.watch(errorProvider).errorType ==
                            "ERROR_FAILED_PASS_CHANGE"
                    ? 0xFFF44336
                    : 0xFF6DC7BD),
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ref.watch(errorProvider).errorType ==
                              "ERROR_PASSWORD_AND_CONFIRMATION_NOT_MATCH" ||
                          ref.watch(errorProvider).errorType ==
                              "ERROR_FAILED_PASS_CHANGE"
                      ? ref.watch(errorProvider).errorMsg
                      : "Password Reset Successful",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ));
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
