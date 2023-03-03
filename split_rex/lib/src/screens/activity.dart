import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/header.dart';


class Activity extends ConsumerWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
      context,
      ref,
      "Activity", 
      "home",
      const Text("hoho")
    );
  }
}
