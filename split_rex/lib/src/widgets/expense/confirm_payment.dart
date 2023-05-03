import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/services/payment.dart';
import '../../common/formatter.dart';
import '../../common/functions.dart';
import '../../providers/payment.dart';

class UnconfirmedPayment extends ConsumerWidget {
  const UnconfirmedPayment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width - 40.0,
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      margin: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: ref.watch(paymentProvider).unconfirmedPayments.isEmpty
          ? Colors.transparent 
          : Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0)
        ),
        boxShadow: [
          BoxShadow(
            color: ref.watch(paymentProvider).unconfirmedPayments.isEmpty 
              ? Colors.transparent 
              : Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0), // Shadow position
          ),
        ],
      ),
      child: (ref.watch(paymentProvider).unconfirmedPayments.isEmpty)
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text("You don't have any payments to confirm",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4F4F4F)
                )
              ),
            )
          ]
        )
        : ListView.separated(
            itemCount: ref.watch(paymentProvider).unconfirmedPayments.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 12),
            itemBuilder: (context, index) {
              return UnconfirmedPaymentDetail(
                name: ref
                  .watch(paymentProvider)
                  .unconfirmedPayments[index]
                  .name,
                paymentId: ref
                  .watch(paymentProvider)
                  .unconfirmedPayments[index]
                  .paymentId,
                totalPaid: ref
                  .watch(paymentProvider)
                  .unconfirmedPayments[index]
                  .totalPaid,
                color: ref
                  .watch(paymentProvider)
                  .unconfirmedPayments[index]
                  .color);
          },
          separatorBuilder: (context, index) => const Divider(
            thickness: 1,
            indent: 20,
            color: Color(0xFFE1F3F2),
          ),
      )
    );
  }
}

class UnconfirmedPaymentDetail extends ConsumerWidget {
  const UnconfirmedPaymentDetail(
      {super.key,
      required this.name,
      required this.totalPaid,
      required this.paymentId,
      required this.color});

  final String name;
  final int totalPaid;
  final String paymentId;
  final int color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.of(context).size.width - 40.0,
      color: const Color(0xFFffffff),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Initicon(
                      text: name,
                      backgroundColor: getProfileBgColor(color),
                      style: TextStyle(color: getProfileTextColor(color)),
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 19.0,
                            color: Color(0xFF4F4F4F),
                            fontWeight: FontWeight.w900
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(children: [
                          const Text(
                            "paid ",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color(0xFF4F4F4F),
                            )
                          ),
                          Text(
                            mFormat(totalPaid.toDouble()),
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Color(0XFF6DC7BD),
                            )
                          ),
                          const Text(
                            " from ",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color(0xFF4F4F4F),
                            )
                          ),
                          Text(
                            ref.watch(groupListProvider).currGroup.name,
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Color(0XFF6DC7BD),
                            )
                          ),
                        ],)
                      ]
                    )
                  ]),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                    InkWell(
                      onTap: () async {
                        confirmationDialog(context, ref, this, false);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Color(0xFFDFF2F0),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        child: const Text(
                          "Deny",
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
                      onTap: () async {
                        confirmationDialog(context, ref, this, true);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Color(0xFF6DC7BD),
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
              ],
            )
          ]
        ),
    );
  }
}

confirmationDialog(BuildContext context, WidgetRef ref, UnconfirmedPaymentDetail widget, bool isConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16.0, 
              left: 16.0, 
              right: 16.0, 
              bottom: 32.0
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(children: [
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: Color(0xFF15808D),
                    ),
                  )
                ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isConfirm ? 'Confirm ' : 'Deny ',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "${widget.name}'s",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900
                      ),
                    ),
                    const Text(
                      " payment",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ]
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text(
                    mFormat(widget.totalPaid.toDouble()),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                  const Text(
                    " from group ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "${ref.watch(groupListProvider).currGroup.name}?",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                ],),
                const SizedBox(height: 24),
                Initicon(
                  text: widget.name,
                  size: 72.0,
                  backgroundColor: getProfileBgColor(widget.color),
                  style: TextStyle(color: getProfileTextColor(widget.color)),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);                                              // await FriendServices().rejectFriendRequest(ref, userId),
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 130,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFFDFF2F0),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: const Text(
                        "Cancel",
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
                    onTap: () async {
                      if (isConfirm) {
                        await PaymentServices().confirmSettle(ref, widget.paymentId);
                      } else {
                        await PaymentServices().denySettle(ref, widget.paymentId);
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 130,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF6DC7BD),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Text(
                        isConfirm ? "Confirm" : "Deny",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ]
              ),
              ],
            ),
          ),
        )
      );
}
