import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/widgets/auth.dart';

import '../../providers/routes.dart';
import '../../services/auth.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  final confNewPassController = TextEditingController();
  final newPassController = TextEditingController();
  final oldPassController = TextEditingController();

  @override
  void dispose() {
    confNewPassController.dispose();
    newPassController.dispose();
    oldPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: header(
        context, 
        ref,
        "Change Password",
        "/edit_account",
        SingleChildScrollView(
          child: 
        Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: Container(
              padding: const EdgeInsets.only(top: 0, left: 4, right: 4, bottom: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              child: 
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(top: 24),
                        child: const Text("Old Password",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4F4F4F),
                          )
                        )
                      ),
                      PasswordField(
                        key: UniqueKey(),
                        controller: oldPassController,
                        placeholderText: "Old Password"
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(top: 24),
                        child: const Text("New Password",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4F4F4F),
                          )
                        )
                      ),
                      PasswordField(
                        key: UniqueKey(),
                        controller: newPassController,
                        placeholderText: "New Password"
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(top: 24),
                        child: const Text("Confirm New Password",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4F4F4F),
                          )
                        )
                      ),
                      PasswordField(
                        key: UniqueKey(),
                        controller: confNewPassController,
                        placeholderText: "Confirm New Password"
                      ),
                      ChangeButton(
                        key: UniqueKey(), 
                        oldPassController: oldPassController, 
                        newPassController: newPassController,
                        confNewPassController: confNewPassController
                      ),
                    ],
                  ),
              ))
            ),
        ),
    );
  }
}

class ChangeButton extends ConsumerWidget {
  final TextEditingController oldPassController;
  final TextEditingController newPassController;
  final TextEditingController confNewPassController;

  const ChangeButton({
    required Key key,
    required this.oldPassController,
    required this.newPassController,
    required this.confNewPassController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
    onTap: () {
      ref.read(authProvider).changeOldPass(oldPassController.text);
      ref.read(authProvider).changeNewPass(newPassController.text);
      ref.read(authProvider).changeConfNewPass(confNewPassController.text);
    
      ApiServices().updatePass(ref, context).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
            padding: const EdgeInsets.all(16),
            height: 70,
            decoration: const BoxDecoration(
                color: Color(0xFF6DC7BD),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Password changed!",
                  style: TextStyle(
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
        ref.read(routeProvider).changePage(context, "/edit_account");
      });
    },
    child: Container(
      padding: const EdgeInsets.only(top: 16),
      margin: const EdgeInsets.all(20),
      child: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Color(0XFF6DC7BD),
          ),
          child: const Text("Change Password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))
        )
      )
    );
  }
}