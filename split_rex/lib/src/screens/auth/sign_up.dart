import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/screens/auth/username_fill.dart';
import 'package:split_rex/src/screens/home.dart';
import 'package:split_rex/src/services/auth.dart';
import 'package:split_rex/src/widgets/auth.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // add async here
          if (snapshot.hasData) {
            // ref.read(routeProvider).changePage("fill_username");

            //  () async {
            // final user = FirebaseAuth.instance.currentUser;
            //   ref.read(authProvider).changeSignUpData(user?.displayName,
            //       user?.displayName, user?.email, user?.uid, user?.uid);
            //   await ApiServices().postRegister(ref);
            //   if (ref.watch(errorProvider).errorType == "ERROR_EMAIL_EXISTED")
            //   {
            //     ref
            //         .read(authProvider)
            //         .changeSignInData(user?.email, user?.uid);
            //     await ApiServices().postLogin(ref);
            //   }}();
            return SingleChildScrollView(
                child: Column(
              children: const [
                UsernameFill(),
                
              ],
            ));
            // ignore: use_build_context_synchronously
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // log("Waiting");
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // log("Error");
            return const Text("Error");
          } else {
            // log("Not signed in");
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
                          key: Key("SignInPage"),
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
            ));
          }
        },
      ),
    );
  }
}
