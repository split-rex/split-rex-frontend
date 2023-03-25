import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/header.dart';
import '../../widgets/settle/settle_up.dart';

class SettleUp extends ConsumerWidget {
  const SettleUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
      context,
      ref,
      "Settle Up",
      "group_detail",
      Column(
        children: const [
          SettleUpBody()
        ],
      ),
    );
  }
}