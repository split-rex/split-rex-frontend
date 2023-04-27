import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/widgets/expense/confirm_payment.dart';

import '../../common/header.dart';


class ConfirmPayment extends ConsumerWidget {
  const ConfirmPayment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: header(
        context,
        ref,
        "Confirm Payment",
        "/group_detail",
        const UnconfirmedPayment()
      ),
    );
  }
}
