import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';

class Account extends ConsumerWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
      context, 
      ref,
      "Account",
      "home",
      const Text("hoho")
    );
  }
}
