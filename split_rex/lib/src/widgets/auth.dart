import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:split_rex/src/providers/routes.dart';

import '../services/auth.dart';

const String assetName = 'assets/LogoSVG.svg';
final Widget svg = SvgPicture.asset(
  assetName,
  semanticsLabel: 'Acme Logo'
);

Widget mainJumbotron(String type) => Container(
  margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
  child: Text(
    type == "signin" ?
      "Sign In" : "Sign Up",
      style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
      ),
    ),
);

Widget subJumbotron(String type) => Container(
  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
  child: Text(
      type == "signin" ? 
        "We’re happy to see you again. To use your account, you should sign in first." 
        : 
        "Enter the fields below to get started.",
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
    return  Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
      child:
      Column(children: [mainJumbotron("signin"), subJumbotron("signin"),
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

        SubmitBtn(
          key: UniqueKey(), 
          emailController: emailController, 
          passController: passController,
          type: "signin",
        )  
      ]
    )
  );
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
      child:
      Column(children: [ mainJumbotron("signup"), subJumbotron("signup"),
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
        )
      ]
    )
  );}
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
        // Write Click Listener Code Here.
        final bool resp;
        if (type == "signin") {
          resp = await ApiServices().postLogin(
            emailController.text,
            passController.text
          );
        } else {
          resp = await ApiServices().postRegister(
            nameController!.text,
            usernameController!.text,
            emailController.text,
            passController.text,
            confController!.text
          );
        }
        if (resp) {
          ref.watch(routeProvider).changePage("home");
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
        child: Text(
          type == "signin" ?
          "Sign In" : "Sign Up",
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}


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

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholderText;
  const PasswordField({
    required Key key,
    required this.controller, 
    required this.placeholderText, 
  }) : super(key: key);
  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _isHidden = true;
  
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
        obscureText: _isHidden,
        controller: widget.controller,
        cursorColor: const Color(0xFF59C4B0),
        decoration: InputDecoration(
          icon: const Icon(
            Icons.lock,
            color: Color(0xFF59C4B0),
          ),
          suffix: InkWell(
                onTap: _togglePasswordView,
                child: Icon(
                        _isHidden 
                        ? Icons.visibility 
                        : Icons.visibility_off,
                    ),
                ),
          hintText: widget.placeholderText,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}

