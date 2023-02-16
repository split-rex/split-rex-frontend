import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String assetName = 'assets/LogoSVG.svg';
final Widget svg = SvgPicture.asset(
  assetName,
  semanticsLabel: 'Acme Logo'
);

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
        hintText: "E-maijjj",
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
);


Widget signInBtn = GestureDetector(
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
      "Sign In",
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
      ),
    ),
  ),
);

// bismillah