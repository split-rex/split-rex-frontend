import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../services/auth.dart';
import './signup.dart';
import '../../home/screens/home.dart';

const String assetName = 'assets/LogoSVG.svg';
final Widget svg = SvgPicture.asset(
  assetName,
  semanticsLabel: 'Acme Logo'
);

Widget mainJumbotron = Container(
  margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
  child: const Text(
      "Sign In",
      style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
      ),
    ),
);

Widget subJumbotron = Container(
  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
  child: const Text(
      "We’re happy to see you again. To use your account, you should sign in first.",
      textAlign: TextAlign.center,
      style: TextStyle(
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
    return  Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
      child:
      Column(children: [mainJumbotron, subJumbotron,
        FormFill(
          key: UniqueKey(),
          controller: emailController,
          icon: Icons.email,
          placeholderText: "E-mail",
        ),
        PasswordField(
          key: UniqueKey(), 
          controller: passController, 
          placeholderText: "Password"
        ),

        SignInBtn(
          key: UniqueKey(), 
          emailController: emailController, 
          passController: passController
        )  
      ]
    )
  );
  }
}

Widget logoWidget = Container(
    margin: const EdgeInsets.only(left: 20, right: 20, top: 60),
    child: Image.asset('assets/Logo.png'),
    
    // child: SvgPicture.asset(
    //   'assets/LogoSVG.svg',
    //   semanticsLabel: 'Acme Logo',
    //   placeholderBuilder: (BuildContext context) => Container(
    //       padding: const EdgeInsets.all(30.0),
    //       child: const CircularProgressIndicator()),
    //   )
    
  
  );


class SignInBtn extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passController;
  
  const SignInBtn({
    required Key key, 
    required this.emailController,
    required this.passController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Write Click Listener Code Here.
        final resp = await ApiServices().postLogin(
          emailController.text,
          passController.text
        );
        if (resp) {
          navigateHome(context);
        } else {
          // make error toast
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
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
                color: Color(0xffEEEEEE)
            ),
          ],
        ),
        child: const Text(
          "Sign In",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
