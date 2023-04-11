import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter/services.dart';
import 'package:split_rex/src/model/payment.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/payment.dart';

import '../../common/functions.dart';
import '../../services/payment.dart';

class SettleUpBody extends ConsumerWidget {
  const SettleUpBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UnsettledPayment curr = ref.watch(paymentProvider).currUnsettledPayment;
    TextEditingController amountController = TextEditingController();

    final double screenHeight = MediaQuery.of(context).size.height - 360;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
        height:  screenHeight - keyboardHeight,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Amount to settle with",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              curr.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 30,
            ),
            (curr.totalUnpaid > 0)
                ? SizedBox(
                    width: MediaQuery.of(context).size.width - 180,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Initicon(
                          text: ref.watch(authProvider).userData.name,
                          size: 79,
                          backgroundColor: getProfileBgColor(
                              ref.watch(authProvider).userData.color),
                          style: TextStyle(
                              color: getProfileTextColor(
                                  ref.watch(authProvider).userData.color)),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Color(0xFFC0C6C5),
                          size: 50,
                        ),
                        Initicon(
                          text: curr.name,
                          size: 79,
                          backgroundColor: getProfileBgColor(curr.color),
                          style:
                              TextStyle(color: getProfileTextColor(curr.color)),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width - 180,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Initicon(
                          text: ref.watch(authProvider).userData.name,
                          size: 79,
                          backgroundColor: getProfileBgColor(
                              ref.watch(authProvider).userData.color),
                          style: TextStyle(
                              color: getProfileTextColor(
                                  ref.watch(authProvider).userData.color)),
                        ),
                        const Icon(
                          Icons.arrow_back,
                          color: Color(0xFFC0C6C5),
                          size: 50,
                        ),
                        Initicon(
                          text: curr.name,
                          size: 79,
                          backgroundColor: getProfileBgColor(curr.color),
                          style:
                              TextStyle(color: getProfileTextColor(curr.color)),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 200,
              child: TextField(
                key: UniqueKey(),
                // style: TextStyle(fontSize: 16),
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
                decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixText: "Rp ",
                    hintText: 'Enter amount to settle',
                    hintStyle: const TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            (curr.totalUnpaid > 0)
                ? RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            color: Color(0xFF4F4F4F),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                        children: [
                          const TextSpan(text: "out of "),
                          TextSpan(
                              text: "Rp.${(curr.totalUnpaid).toString()}",
                              style: const TextStyle(
                                  color: Color(0xffFF0000),
                                  fontWeight: FontWeight.bold)),
                          const TextSpan(text: " you owed"),
                        ]),
                  )
                : RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            color: Color(0xFF4F4F4F),
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                        children: [
                          const TextSpan(text: "out of "),
                          TextSpan(
                              text: "Rp.${(-1 * curr.totalUnpaid).toString()} ",
                              style: const TextStyle(
                                  color: Color(0xFF6DC7BD),
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: curr.name,
                              style: const TextStyle(
                                  color: Color(0xFF6DC7BD),
                                  fontWeight: FontWeight.bold)),
                          const TextSpan(text: " lent"),
                        ]),
                  ),
            const SizedBox(height: 20),
            SettleUpButton(amountController: amountController),
          ],
        )));
  }
}

class SettleUpButton extends ConsumerWidget {
  const SettleUpButton({super.key, required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UnsettledPayment curr = ref.watch(paymentProvider).currUnsettledPayment;

    return GestureDetector(
      onTap: () async {
        if (amountController.text.isEmpty) {
          return;
        }

        int amount = int.parse(amountController.text);
        if (curr.totalUnpaid > 0) {
          await PaymentServices()
              .settlePaymentOwed(ref, curr.paymentId, amount);
        } else {
          await PaymentServices()
              .settlePaymentLent(ref, curr.paymentId, amount);
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: 40,
        width: MediaQuery.of(context).size.width - 280,
        decoration: BoxDecoration(
          color: const Color(0xFF6DC7BD),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xffEEEEEE)),
          ],
        ),
        child: const Text(
          "Settle Up",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
