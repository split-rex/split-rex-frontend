import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter/services.dart';
import 'package:split_rex/src/model/payment.dart';
import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/payment.dart';

import '../../common/formatter.dart';
import '../../common/functions.dart';
import '../../services/payment.dart';

class SettleUpBody extends ConsumerWidget {
  const SettleUpBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UnsettledPayment curr = ref.watch(paymentProvider).currUnsettledPayment;
    TextEditingController amountController = TextEditingController();

    return SizedBox(
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
                ],
                decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixText: "IDR ",
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
                              text: mFormat(curr.totalUnpaid),
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
                              text: mFormat(curr.totalUnpaid * -1),
                              style: const TextStyle(
                                  color: Color(0xFF6DC7BD),
                                  fontWeight: FontWeight.bold)),
                          const TextSpan(text: " you lent"),
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
        EasyLoading.instance
          ..displayDuration = const Duration(seconds: 3)
          ..indicatorType = EasyLoadingIndicatorType.fadingCircle
          ..loadingStyle = EasyLoadingStyle.custom
          ..indicatorSize = 45.0
          ..radius = 16.0
          ..textColor = Colors.white
          ..progressColor = const Color(0xFF4F9A99)
          ..backgroundColor = const Color(0xFF4F9A99)
          ..indicatorColor = Colors.white
          ..maskType = EasyLoadingMaskType.custom
          ..maskColor = const Color.fromARGB(155, 255, 255, 255);
        EasyLoading.show(
            status: 'Loading...', maskType: EasyLoadingMaskType.custom);
        double amount = double.parse(amountController.text);
        if (curr.totalUnpaid > 0) {
          await PaymentServices()
              .settlePaymentOwed(ref, curr.paymentId, amount, context).then((value) {
                EasyLoading.dismiss();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Container(
                    padding: const EdgeInsets.all(16),
                    height: 70,
                    decoration: const BoxDecoration(
                        color: Color(0xFF6DC7BD),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Payment settled! Waiting for friend's confirmation.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ));
              });
        } else {
          await PaymentServices()
              .settlePaymentLent(ref, curr.paymentId, amount, context).then((value) {
                EasyLoading.dismiss();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Container(
                    padding: const EdgeInsets.all(16),
                    height: 70,
                    decoration: const BoxDecoration(
                        color: Color(0xFF6DC7BD),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Payment settled!",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ));
              });
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
