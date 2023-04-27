import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/logger.dart';
import 'package:split_rex/src/providers/payment.dart';
import 'package:split_rex/src/providers/routes.dart';
import '../../services/notification.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../common/functions.dart';

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
            ? Container(
                padding: const EdgeInsets.all(10),
                child: const Text("You don't have any unsettled payments",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4F4F4F))),
              )
            : ListView.separated(
                itemCount: ref.watch(paymentProvider).unsettledPayments.length,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemBuilder: (context, index) {
                  return UnsettlePaymentDetail(
                      index: index,
                      name: ref
                          .watch(paymentProvider)
                          .unsettledPayments[index]
                          .name,
                      userId: ref
                          .watch(paymentProvider)
                          .unsettledPayments[index]
                          .userId,
                      color: ref
                          .watch(paymentProvider)
                          .unsettledPayments[index]
                          .color,
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
      required this.color,
      required this.index,
      required this.oweOrLent});

  final String name;
  final String userId;
  final int color;
  final int index;
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
              child: Initicon(
                text: name,
                backgroundColor: getProfileBgColor(color),
                style: TextStyle(color: getProfileTextColor(color)),
              ),
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
                (oweOrLent > 0)
                    ? RichText(
                        text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF4F4F4F),
                            ),
                            children: [
                              const TextSpan(text: "You owe "),
                              TextSpan(
                                  text: "Rp.${oweOrLent.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xffFF0000))),
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
                              TextSpan(
                                  text: "Rp.${(-1 * oweOrLent).toString()}",
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
                    onTap: () async {
                      if (oweOrLent > 0) {
                        logger.d("haha");
                        var reminderID = Random().nextInt(99);
                        try {
                          await flutterLocalNotificationsPlugin.zonedSchedule(
                            reminderID,
                            "Settle your payments!",
                            "Don't forget to pay Rp.${oweOrLent.toString()} to $name",
                            tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
                            NotificationDetails(
                              android: AndroidNotificationDetails(
                                "$reminderID", 
                                "reminderChannel",
                                color: const Color(0xFF5CC6BF),
                              )
                            ),
                            uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
                          );
                          logger.d("anjay");
                        } catch (error) {
                          logger.d(error);
                        }
                        logger.d("hoho");
                      } else {
                        null;
                      }
                    },
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
                    onTap: () async {
                      ref
                          .watch(paymentProvider)
                          .changeCurrUnsettledPayment(index);
                      ref.read(routeProvider).changePage(context, "/settle_up");
                    },
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
