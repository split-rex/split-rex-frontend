import 'package:flutter/material.dart';
import '../widgets/signup.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => InitState();
}
class InitState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) => initWidget();

  Widget initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
  
              children: [
                logoWidget,
                fillName,
                fillEmail,
                fillPassword,
                fillConfirmationPassword,
                sigupBtn,
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Have an account?  "),
                      GestureDetector(
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                          ),
                        ),
                        onTap: () {
                          // Write Tap Code Here.
                          Navigator.pop(context);
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
}