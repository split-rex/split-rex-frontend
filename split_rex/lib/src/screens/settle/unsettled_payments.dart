import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/header.dart';
import '../../widgets/settle/unsettled_payments.dart';

class UnsettledPayments extends ConsumerWidget {
  const UnsettledPayments({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return header(
      context,
      ref,
      "Unsettled Payments",
      "group_detail",
      Column(
        children: const [UnsettledPaymentsBody()],
      ),
    );
  }
}
