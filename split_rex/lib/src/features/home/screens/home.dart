import 'package:flutter/material.dart';
import '../widgets/home.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Column(
          children: [
            HomeHeader(),
            Expanded(
              child: 
                HomeFooter()
            )
          ],
        )
      ),
    );
  }
}
