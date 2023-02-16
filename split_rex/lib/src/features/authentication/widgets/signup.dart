import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../services/auth.dart';
import '../screens/signin.dart';

const String assetName = 'assets/LogoSVG.svg';
final Widget svg = SvgPicture.asset(
  assetName,
  semanticsLabel: 'Acme Logo'
);

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
      child:
      Column(children: [
        FormFill(key: UniqueKey(),controller: nameController,
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
        FormFill(
          key: UniqueKey(),
          controller: passController,
          icon: Icons.lock,
          placeholderText: "Password",
        ),
        FormFill(
          key: UniqueKey(),
          controller: confPassController,
          icon: Icons.lock,
          placeholderText: "Confirm Password",
        ),
        SignUpBtn(
          key: UniqueKey(), 
          nameController: nameController, 
          usernameController: usernameController, 
          emailController: emailController, 
          passController: passController
        )
      ]
    )
  );}
}

Widget logoWidget = Container(
    // margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
    child: svg,
    // child: SvgPicture.asset(
    //   'assets/LogoSVG.svg',
    //   semanticsLabel: 'Acme Logo',
    //   placeholderBuilder: (BuildContext context) => Container(
    //       padding: const EdgeInsets.all(30.0),
    //       child: const CircularProgressIndicator()),
    //   )
);

class FormFill extends StatelessWidget {
  final TextEditingController controller;
  final String placeholderText;
  final IconData icon;
  
  const FormFill({
    required Key key, 
    required this.controller, 
    required this.placeholderText, 
    required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 17),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 50,
              color: Color(0xffEEEEEE)
          ),
        ],
      ),
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
        ),
      ),
    );
  }
}

class SignUpBtn extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passController;
  
  const SignUpBtn({
    required Key key, 
    required this.nameController, 
    required this.usernameController, 
    required this.emailController,
    required this.passController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Write Click Listener Code Here.
        ApiServices().postRegister(
          nameController.text,
          usernameController.text,
          emailController.text,
          passController.text,
        );
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SignInScreen()
        ));
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
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
