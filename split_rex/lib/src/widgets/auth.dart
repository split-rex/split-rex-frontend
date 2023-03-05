import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:split_rex/src/providers/auth.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:split_rex/src/providers/error.dart';
import '../services/auth.dart';

const String assetName = 'assets/LogoSVG.svg';
final Widget svg = SvgPicture.asset(assetName, semanticsLabel: 'Acme Logo');

Widget mainJumbotron(String type) => Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
      child: Text(
        type == "signin" ? "Sign In" : "Sign Up",
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
        ),
      ),
    );

Widget subJumbotron(String type) => Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Text(
        type == "signin"
            ? "We’re happy to see you again. To use your account, you should sign in first."
            : "Enter the fields below to get started.",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
        child: Column(children: [
          mainJumbotron("signin"),
          subJumbotron("signin"),
          FormFill(
            key: UniqueKey(),
            controller: emailController,
            icon: Icons.email,
            placeholderText: "E-mail",
          ),
          PasswordField(
              key: UniqueKey(),
              controller: passController,
              placeholderText: "Password"),
          SubmitBtn(
            key: UniqueKey(),
            emailController: emailController,
            passController: passController,
            type: "signin",
          ),
          const SizedBox(height: 30),
          SignInButton(Buttons.Google, onPressed: () {
            // sign in google
          }),
          const SizedBox(height: 5),
          SignInButton(Buttons.Facebook, onPressed: () {
            //  sign in facebook
          }),
          const SizedBox(height: 10),
        ]));
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confPassController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passController.dispose();
    confPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
        child: Column(children: [
          mainJumbotron("signup"),
          subJumbotron("signup"),
          FormFill(
            key: UniqueKey(),
            controller: nameController,
            icon: Icons.person,
            placeholderText: "Full Name",
          ),
          FormFill(
            key: UniqueKey(),
            controller: usernameController,
            icon: Icons.verified_user,
            placeholderText: "Username",
          ),
          FormFill(
            key: UniqueKey(),
            controller: emailController,
            icon: Icons.email,
            placeholderText: "E-mail",
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
          SubmitBtn(
            key: UniqueKey(),
            nameController: nameController,
            usernameController: usernameController,
            emailController: emailController,
            passController: passController,
            confController: confPassController,
            type: "signup",
          ),
          const SizedBox(height: 30),
          SignInButton(Buttons.Google,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)), onPressed: () {
            // sign up google
          }),
          const SizedBox(height: 5),
          SignInButton(Buttons.Facebook,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)), onPressed: () {
            //  sign up facebook
          }),
          const SizedBox(height: 10),
        ]));
  }
}

class SubmitBtn extends ConsumerWidget {
  final TextEditingController? nameController;
  final TextEditingController? usernameController;
  final TextEditingController emailController;
  final TextEditingController passController;
  final TextEditingController? confController;
  final String type;

  const SubmitBtn({
    required Key key,
    this.nameController,
    this.usernameController,
    required this.emailController,
    required this.passController,
    this.confController,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        if (type == "signin") {
          ref
              .read(authProvider)
              .changeSignInData(emailController.text, passController.text);
          await ApiServices().postLogin(ref);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
              padding: const EdgeInsets.all(16),
              height: 70,
              decoration: BoxDecoration(
                  color: Color(
                      ref.watch(errorProvider).errorMsg == "Login Failed"
                          ? 0xFFF44336
                          : 0xFF388E3C),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ref.watch(errorProvider).errorMsg == "Login Failed"
                        ? "Login failed, email or password are wrong!"
                        : "Logged in successfully!",
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
        } else {
          ref.read(authProvider).changeSignUpData(
              nameController!.text,
              usernameController!.text,
              emailController.text,
              passController.text,
              confController!.text);
          await ApiServices().postRegister(ref);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Container(
              padding: const EdgeInsets.all(16),
              height: 70,
              decoration: BoxDecoration(
                  color: Color(
                          ref.watch(errorProvider).errorType ==
                              "ERROR_FAILED_REGISTER" ||
                          ref
                                  .watch(errorProvider)
                                  .errorType ==
                              "ERROR_USERNAME_EXISTED" ||
                          ref
                                  .watch(errorProvider)
                                  .errorType ==
                              "ERROR_EMAIL_EXISTED" ||
                          ref.watch(errorProvider).errorType ==
                              "ERROR: INVALID USERNAME OR PASSWORD" ||
                          ref.watch(errorProvider).errorType ==
                              "ERROR_PASSWORD_AND_CONFIRMATION_NOT_MATCH" ||
                          ref.watch(errorProvider).errorType ==
                            "ERROR_INVALID_EMAIL"
                      ? 0xFFF44336
                      : 0xFF388E3C),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                     ref.watch(errorProvider).errorType ==
                              "ERROR_FAILED_REGISTER" ||
                          ref
                                  .watch(errorProvider)
                                  .errorType ==
                              "ERROR_USERNAME_EXISTED" ||
                          ref
                                  .watch(errorProvider)
                                  .errorType ==
                              "ERROR_EMAIL_EXISTED" ||
                          ref.watch(errorProvider).errorType ==
                              "ERROR: INVALID USERNAME OR PASSWORD" ||
                          ref.watch(errorProvider).errorType ==
                              "ERROR_PASSWORD_AND_CONFIRMATION_NOT_MATCH" ||
                          ref.watch(errorProvider).errorType ==
                              "ERROR_INVALID_EMAIL"
                        ? ref.watch(errorProvider).errorMsg
                        : "Registered successfully!",
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
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: 54,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF59C4B0),
              Color(0XFF43A7B7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xffEEEEEE)),
          ],
        ),
        child: Text(
          type == "signin" ? "Sign In" : "Sign Up",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class FormFill extends ConsumerWidget {
  final TextEditingController controller;
  final String placeholderText;
  final IconData icon;

  const FormFill(
      {required Key key,
      required this.controller,
      required this.placeholderText,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 17),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 41,
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
          border: Border.all(
              color: Color(
                (ref.watch(errorProvider).errorType == "ERROR_USERNAME_EXISTED" && placeholderText == "Username") ||
                (ref.watch(errorProvider).errorType == "ERROR_INVALID_EMAIL" && placeholderText == "E-mail") ||
                (ref.watch(errorProvider).errorType == "ERROR_EMAIL_EXISTED" && placeholderText == "E-mail") ||
                (ref.watch(errorProvider).errorType == "ERROR: INVALID USERNAME OR PASSWORD" && placeholderText == "Username")
                  ? 0xFFF44336 : 0xffEEEEEE))),
      child: TextField(
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
      height: 41,
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
              color: Color(
                (ref.watch(errorProvider).errorType == "ERROR: INVALID USERNAME OR PASSWORD" && placeholderText == "Password") ||
                (ref.watch(errorProvider).errorType == "ERROR_PASSWORD_AND_CONFIRMATION_NOT_MATCH" && placeholderText == "Password") ||
                (ref.watch(errorProvider).errorType == "ERROR_PASSWORD_AND_CONFIRMATION_NOT_MATCH" && placeholderText == "Confirm Password") 
                  ? 0xFFF44336
                  : 0xffEEEEEE))),
      child: TextField(
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
