import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/header.dart';
import '../../widgets/settle/settle_up.dart';

class SettleUp extends ConsumerWidget {
  const SettleUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: header(
        context,
        ref,
        "Settle Up",
        "/unsettled_payments",
        Column(
          children: const [
            SettleUpBody()
          ],
        ),
      ),
    );
  }
}
