import 'package:flutter/material.dart';
import 'package:split_rex/src/widgets/navbar.dart';
import '../widgets/home.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const Navbar(),
      body: Column(
        children: const [
          HomeHeader(),
          Expanded(
            child: 
              HomeFooter()
          )
        ],
      ),
    );
  }
}
