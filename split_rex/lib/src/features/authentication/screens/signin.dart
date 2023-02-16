import 'package:flutter/material.dart';
import 'package:split_rex/src/features/authentication/screens/signup.dart';
import '../widgets/signin.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() => InitState();
}
class InitState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) => initWidget();

  Widget initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
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
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUpScreen()
                          ));
                        },
                      )
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}// bismillah