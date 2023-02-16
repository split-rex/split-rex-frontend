import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String assetName = 'assets/LogoSVG.svg';
final Widget svg = SvgPicture.asset(
  assetName,
  semanticsLabel: 'Acme Logo'
);

Widget mainJumbotron = Container(
  margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
  child: const Text(
      "Sign Up",
      style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
      ),
    ),
);

Widget subJumbotron = Container(
  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
  child: const Text(
      "Enter the fields below to get started.",
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
      ),
    ),
);

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

Widget fillName = Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
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
    child: const TextField(
      cursorColor: Color(0xFF59C4B0),
      decoration: InputDecoration(
        icon: Icon(
          Icons.person,
          color: Color(0xFF59C4B0),
        ),
        hintText: "Full Name",
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ),
  );

  Widget fillEmail = Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
    child: const TextField(
      cursorColor: Color(0xFF59C4B0),
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          color: Color(0xFF59C4B0),
        ),
        hintText: "E-mail",
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ),
  );

Widget fillPassword = Container(
  alignment: Alignment.center,
  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
  padding: const EdgeInsets.only(left: 20, right: 20),
  height: 54,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: const Color(0xffEEEEEE),
    boxShadow: const [
      BoxShadow(
          offset: Offset(0, 20),
          blurRadius: 100,
          color: Color(0xffEEEEEE)
      ),
    ],
  ),
  child: const TextField(
    cursorColor: Color(0xFF59C4B0),
    textInputAction: TextInputAction.done,
    obscureText: true,
    decoration: InputDecoration(
      focusColor: Color(0xFF59C4B0),
      icon: Icon(
        Icons.lock,
        color: Color(0xFF59C4B0),
      ),
      hintText: "Password",
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
    ),
  ),

  // TextFormField(
  //             textInputAction: TextInputAction.done,
  //             obscureText: true,
  //             cursorColor: kPrimaryColor,
  //             decoration: InputDecoration(
  //               hintText: "Your password",
  //               prefixIcon: Padding(
  //                 padding: const EdgeInsets.all(defaultPadding),
  //                 child: Icon(Icons.lock),
  //               ),

);

Widget fillConfirmationPassword = Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
    padding: const EdgeInsets.only(left: 20, right: 20),
    height: 54,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: const Color(0xffEEEEEE),
      boxShadow: const [
        BoxShadow(
            offset: Offset(0, 20),
            blurRadius: 100,
            color: Color(0xffEEEEEE)
        ),
      ],
    ),
    child: const TextField(
      cursorColor: Color(0xFF59C4B0),
      decoration: InputDecoration(
        focusColor: Color(0xFF59C4B0),
        icon: Icon(
          Icons.lock,
          color: Color(0xFF59C4B0),
        ),
        hintText: "Confirm Password",
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ),
  );

Widget sigupBtn = GestureDetector(
  onTap: () {
    // Write Click Listener Code Here.
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
      "Sign Up",
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
      ),
    ),
  ),
);

