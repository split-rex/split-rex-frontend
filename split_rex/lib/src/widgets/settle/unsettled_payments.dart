import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/payment.dart';

class UnsettledPaymentsBody extends ConsumerWidget {
  const UnsettledPaymentsBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        margin: const EdgeInsets.only(left: 28.0, right: 28.0),
        width: 349,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 0), // Shadow position
            ),
          ],
        ),
        child: (ref.watch(paymentProvider).unsettledPayments.isEmpty)
            ? Text("No unsettled payments!")
            : ListView.separated(
                itemCount: ref.watch(paymentProvider).unsettledPayments.length,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemBuilder: (context, index) {
                  return UnsettlePaymentDetail(
                      name: ref
                          .watch(paymentProvider)
                          .unsettledPayments[index]
                          .name,
                      userId: ref
                          .watch(paymentProvider)
                          .unsettledPayments[index]
                          .userId,
                      oweOrLent: ref
                          .watch(paymentProvider)
                          .unsettledPayments[index]
                          .totalUnpaid);
                },
                separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                      indent: 20,
                      color: Color(0xFFE1F3F2),
                    )));
  }
}

class UnsettlePaymentDetail extends ConsumerWidget {
  const UnsettlePaymentDetail(
      {super.key,
      required this.name,
      required this.userId,
      required this.oweOrLent});

  final String name;
  final String userId;
  final int oweOrLent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 348,
      color: const Color(0xFFffffff),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: Initicon(text: name),
            ),
            const SizedBox(width: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 19.0,
                      color: Color(0xFF4F4F4F),
                      fontWeight: FontWeight.w900),
                ),
                // TODO: ADA IF ELSENYA BEDA RICHTEXT!!!
                (oweOrLent > 0)
                    ? RichText(
                        text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF4F4F4F),
                            ),
                            children: [
                              const TextSpan(text: "You owes "),
                              const TextSpan(
                                  text: "Rp. ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF6DC7BD))), // TODO: change to red
                              TextSpan(
                                  text: (oweOrLent).toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF6DC7BD))),
                            ]),
                      )
                    : RichText(
                        text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF4F4F4F),
                            ),
                            children: [
                              const TextSpan(text: "owes "),
                              const TextSpan(
                                  text: "Rp.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF6DC7BD))),
                              TextSpan(
                                  text: (-1 * oweOrLent).toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF6DC7BD))),
                              const TextSpan(text: " to "),
                              const TextSpan(
                                  text: "You",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  )),
                            ]),
                      ),
                const SizedBox(height: 8),
                Row(children: [
                  InkWell(
                    // onTap: () async =>
                    //     await FriendServices().rejectFriendRequest(ref, userId),
                    child: Container(
                      alignment: Alignment.center,
                      width: 117,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFFDFF2F0),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: const Text(
                        "Remind",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2E9281),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    // onTap: () async {
                    //   await FriendServices().acceptFriendRequest(ref, userId);
                    // },
                    child: Container(
                      alignment: Alignment.center,
                      width: 117,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF6DC7BD),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: const Text(
                        "Settle Up",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            )
          ]),
    );
  }
}
