import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/logger.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/services/auth.dart';
import 'package:split_rex/src/widgets/auth.dart';

class UsernameFill extends StatefulWidget {
  const UsernameFill({super.key});

  @override
  State<UsernameFill> createState() => _UsernameFillState();
}

class _UsernameFillState extends State<UsernameFill> {
  final usernamecontroller = TextEditingController();

  @override
  void dispose() {
    usernamecontroller.dispose();
    super.dispose();
  }


  
  @override
  Widget build(BuildContext context) {
    return 
        SingleChildScrollView(
            child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
              child: Column(children: [
                mainJumbotron("Create your username"),
                subJumbotron("username"),
                Container(
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
          border: Border.all(
              color: const Color(0xffEEEEEE))),
      child:
                TextField(

                  controller: usernamecontroller,
                  cursorColor: const Color(0xFF59C4B0),
                  decoration: const InputDecoration(
                      icon: Icon(
                        Icons.verified_user,
                        color: Color(0xFF59C4B0),
                      ),
                      hintText: "username",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 14,
                  )),
                )),
                SetUsername(
                  key: UniqueKey(),
                  usernamecontroller: usernamecontroller,
                ),
              ]),
            ),
          ],
        ));
  }
}

class SetUsername extends ConsumerWidget {
  final TextEditingController usernamecontroller;

  const SetUsername({
    required Key key,
    required this.usernamecontroller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    return GestureDetector(
      onTap: () async {
        ref.read(authProvider).changeSignUpData(user?.displayName,
            usernamecontroller.text, user?.email, user?.uid, user?.uid);
        await ApiServices().postRegister(ref);
        // ignore: use_build_context_synchronously
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Container(
        //     padding: const EdgeInsets.all(16),
        //     height: 70,
        //     decoration: BoxDecoration(
        //         color: Color(ref.watch(errorProvider).errorType ==
        //                     "ERROR_FAILED_REGISTER" ||
        //                 ref.watch(errorProvider).errorType ==
        //                     "ERROR_USERNAME_EXISTED" ||
        //                 ref.watch(errorProvider).errorType ==
        //                     "ERROR_EMAIL_EXISTED" ||
        //                 ref.watch(errorProvider).errorType ==
        //                     "ERROR: INVALID USERNAME OR PASSWORD" ||
        //                 ref.watch(errorProvider).errorType ==
        //                     "ERROR_PASSWORD_AND_CONFIRMATION_NOT_MATCH" ||
        //                 ref.watch(errorProvider).errorType ==
        //                     "ERROR_INVALID_EMAIL"
        //             ? 0xFFF44336
        //             : 0xFF388E3C),
        //         borderRadius: const BorderRadius.all(Radius.circular(15))),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           ref.watch(errorProvider).errorType ==
        //                       "ERROR_FAILED_REGISTER" ||
        //                   ref.watch(errorProvider).errorType ==
        //                       "ERROR_USERNAME_EXISTED" ||
        //                   ref.watch(errorProvider).errorType ==
        //                       "ERROR_EMAIL_EXISTED" ||
        //                   ref.watch(errorProvider).errorType ==
        //                       "ERROR: INVALID USERNAME OR PASSWORD" ||
        //                   ref.watch(errorProvider).errorType ==
        //                       "ERROR_PASSWORD_AND_CONFIRMATION_NOT_MATCH" ||
        //                   ref.watch(errorProvider).errorType ==
        //                       "ERROR_INVALID_EMAIL"
        //               ? ref.watch(errorProvider).errorMsg
        //               : "Registered successfully!",
        //           style: const TextStyle(
        //             fontSize: 16,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   behavior: SnackBarBehavior.floating,
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ));
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
        child: const Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
