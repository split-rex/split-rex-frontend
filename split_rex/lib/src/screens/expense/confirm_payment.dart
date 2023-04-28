import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/widgets/expense/confirm_payment.dart';

import '../../common/header.dart';
import '../../services/payment.dart';


class ConfirmPayment extends ConsumerWidget {
  const ConfirmPayment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        onRefresh: () => _pullRefresh(ref),
        child: (
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: header(
                context,
                ref,
                "Confirm Payment",
                "/group_detail",
                const UnconfirmedPayment()
              ),
            )
          )
        )
      )
    );
  }

  Future<void> _pullRefresh(WidgetRef ref) async {
    await PaymentServices().getUnconfirmedPayment(ref);
  }
}
