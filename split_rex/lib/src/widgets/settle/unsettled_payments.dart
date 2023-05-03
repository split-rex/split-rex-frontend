import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/logger.dart';
import 'package:split_rex/src/providers/payment.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/services/scheduled_notification.dart';
import '../../common/formatter.dart';
import '../../providers/group_list.dart';
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
                                  text: mFormat(oweOrLent.toDouble()),
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
                                  text: mFormat(oweOrLent.toDouble() * -1),
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
                    onTap: () {
                      var currentDate = DateTime.now();
                      DatePicker.showDateTimePicker(
                        context,
                        showTitleActions: true,
                        minTime: currentDate.add(const Duration(seconds: 60)),
                        maxTime: currentDate.add(const Duration(days: 365)),
                        theme: const DatePickerTheme(
                          headerColor: Colors.white,
                          backgroundColor: Colors.white,
                          itemStyle: TextStyle(
                              color: Color(0xFF6DC7BD),
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                          doneStyle: TextStyle(color: Color(0xFF38AFA2), fontSize: 16, fontWeight: FontWeight.bold)
                        ),
                        onConfirm: (date) {
                          _setReminder(name, userId, oweOrLent, date, currentDate, context, ref);
                        }, 
                        currentTime: currentDate.add(const Duration(seconds: 60)), 
                        locale: LocaleType.en
                      );
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

  void _setReminder(String name, String userId, int oweOrLent, DateTime destinedTime, DateTime curTime, BuildContext context, WidgetRef ref) async {
    if (oweOrLent > 0) {
      logger.d(destinedTime);
      logger.d(curTime);
      var intervalSeconds = 0;
      if (curTime.isAfter(destinedTime)) {
        intervalSeconds = 1;
      } else {
        intervalSeconds = destinedTime.difference(curTime).inSeconds;
      }
      var reminderID = curTime;

      logger.d(intervalSeconds);
      
      try {
        await flutterLocalNotificationsPlugin.zonedSchedule(
          reminderID.microsecond,
          "Let's settle up!",
          "Don't forget to pay ${mFormat(oweOrLent.toDouble())} to $name in group '${ref.watch(groupListProvider).currGroup.name}'",
          tz.TZDateTime.now(tz.local).add(Duration(seconds: intervalSeconds)),
          NotificationDetails(
            android: AndroidNotificationDetails(
              "$reminderID", 
              "Self Reminder",
              color: const Color(0xFF5CC6BF),
            )
          ),
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        ).then((value) {
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
                  "Reminder set!",
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
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
            padding: const EdgeInsets.all(16),
            height: 70,
            decoration: const BoxDecoration(
                color: Color(0xFFF44336),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Unable to set reminder!",
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
      }
    } else {
      ScheduledNotificationServices().insertScheduledNotifation(
        context, ref, userId, (-1 * oweOrLent), destinedTime
      );
    }
  }
}
