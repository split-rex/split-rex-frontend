import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:split_rex/src/services/auth.dart';
import 'package:split_rex/src/screens/auth/username_fill.dart';

import '../../widgets/auth.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot)  {
          // add async here
          if (snapshot.hasData) {
            log("has data");
            // ref.read(routeProvider).changePage(context, "/fill_username");

             () async {
            final user = FirebaseAuth.instance.currentUser;
              ref
                    .read(authProvider)
                    .changeSignInData(user?.email, user?.uid);
              log("FIREBASE LOGIN");
              await ApiServices().postLogin(ref, context);
              
              }();
              
              if (ref.watch(errorProvider).errorType == "ERROR_FAILED_LOGIN")
              {
               
                
                return SingleChildScrollView(
                    child: Column(
                  children: const [
                    UsernameFill(),
                  ],
                ));
              }
            return const Center(child: CircularProgressIndicator());
            
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else {
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
                          ref.read(routeProvider).changePage(context, "/sign_up");
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
}// bismillah