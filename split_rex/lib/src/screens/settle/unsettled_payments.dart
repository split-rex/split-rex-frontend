import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/header.dart';
import '../../services/payment.dart';
import '../../widgets/settle/unsettled_payments.dart';

class UnsettledPayments extends ConsumerWidget {
  const UnsettledPayments({super.key});

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
                "Unsettled Payments",
                "/group_detail",
                Column(
                  children: const [UnsettledPaymentsBody()],
                ),
              ),
            )
          )
        )
      )
    );
  }

  Future<void> _pullRefresh(WidgetRef ref) async {
    await PaymentServices().getUnsettledPayment(ref);
  }
}
