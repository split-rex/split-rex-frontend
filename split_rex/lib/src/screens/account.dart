import 'package:flutter/material.dart';
import 'package:split_rex/src/common/header.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return header(
      context, 
      "Account",
      const Text("hoho")
    );
  }
}
