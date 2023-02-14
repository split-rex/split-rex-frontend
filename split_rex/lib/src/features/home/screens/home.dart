import 'package:flutter/material.dart';
import '../widgets/home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        homeHeader,
        Expanded(child: 
          homeFooter
        )
      ],
    );
  }
}
