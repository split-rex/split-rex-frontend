import 'package:flutter/material.dart';
import 'package:split_rex/src/common/header.dart';


class Activity extends StatelessWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context) {
    return header(
      context,
      "Activity", 
      const Text("hoho")
    );
  }
}
