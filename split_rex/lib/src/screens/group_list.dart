import 'package:flutter/material.dart';
import 'package:split_rex/src/common/header.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return header(
      context, 
      "Group List",
      const Text("hoho")
    );
  }
}
