import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:split_rex/src/features/authentication/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.manropeTextTheme().apply(
          bodyColor: const Color(0xFF4F4F4F),
          displayColor: const Color(0xFF4F4F4F),
        ),
      ),
      home: const Scaffold(
        body: SignUpScreen()
      ),
    );
  }
}
