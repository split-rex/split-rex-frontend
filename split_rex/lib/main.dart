import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './src/features/home/screens/home.dart';

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
          bodyColor: Color(0xFF4F4F4F),
          displayColor: Color(0xFF4F4F4F),
        ),
      ),
      home: const Scaffold(
        body: Home()
      ),
    );
  }
}
