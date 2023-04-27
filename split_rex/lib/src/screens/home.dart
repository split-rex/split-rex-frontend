import 'package:flutter/material.dart';
import 'package:split_rex/src/common/logger.dart';
import '../widgets/home.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Column(
          children: const [
            HomeHeader(),
            Expanded(
              child: 
                HomeFooter()
            )
          ],
        );
  }
}
