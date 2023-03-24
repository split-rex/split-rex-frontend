// NANDO WAS HERE

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:split_rex/src/widgets/navbar.dart';
import 'package:split_rex/src/routes/routes.dart';

import 'package:split_rex/src/providers/routes.dart';
import 'package:firebase_core/firebase_core.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Split-rex',
      theme: ThemeData(
        textTheme: GoogleFonts.manropeTextTheme().apply(
          bodyColor: const Color(0xFF4F4F4F),
          displayColor: const Color(0xFF4F4F4F),
        ),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: 
          ref.watch(routeProvider).isNavbarRevealed 
          ? const Navbar() : null,
        body: const PageRouting(),
      ),
    );
  }
}
