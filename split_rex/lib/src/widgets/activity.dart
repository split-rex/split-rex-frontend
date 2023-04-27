import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/common/functions.dart';
import 'package:split_rex/src/providers/activity.dart';
import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:split_rex/src/services/add_expense.dart';
import 'package:split_rex/src/services/group.dart';
import 'package:split_rex/src/services/payment.dart';

Widget activityListWidget(BuildContext context, WidgetRef ref) {
  return SizedBox(
      width: MediaQuery.of(context).size.width - 40.0,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.zero,
          // shrinkWrap: true,
          // padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemCount: ref.watch(activityProvider).activities.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              key: ValueKey(
                  ref.watch(activityProvider).activities[index].activityId),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ref
                                .watch(activityProvider)
                                .activities[index]
                                .activityType ==
                            "PAYMENT"
                        ? SvgPicture.asset(
                            "assets/payment.svg",
                            width: 20,
                            height: 20,
                          )
                        : ref
                                    .watch(activityProvider)
                                    .activities[index]
                                    .activityType ==
                                "TRANSACTION"
                            ? SvgPicture.asset(
                                "assets/transaction.svg",
                                width: 20,
                                height: 20,
                              )
                            : SvgPicture.asset(
                                "assets/reminder.svg",
                                width: 20,
                                height: 20,
                              ),
                    ref
                                .watch(activityProvider)
                                .activities[index]
                                .activityType ==
                            "PAYMENT"
                        ? ref
                                    .watch(activityProvider)
                                    .activities[index]
                                    .status ==
                                "UNCONFIRMED"
                            ? Expanded(
                                child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: RichText(
                                  softWrap: true,
                                  text: TextSpan(
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0XFF4f4f4f),
                                          fontWeight: FontWeight.w400),
                                      children: [
                                        TextSpan(
                                          text: ref
                                              .watch(activityProvider)
                                              .activities[index]
                                              .name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: " just settled ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              "Rp.${formatNumber(ref.watch(activityProvider).activities[index].amount!)}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: " with ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: "You",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "\nView Settlement",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF4F9A99)),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              ref
                                                  .read(groupListProvider)
                                                  .changeCurrGroupById(ref
                                                      .watch(activityProvider)
                                                      .activities[index]
                                                      .redirectId);
                                              GroupServices()
                                              .getGroupTransactions(ref).then((val) {
                                                PaymentServices()
                                                .getUnconfirmedPayment(ref).then((val) {
                                                  ref
                                                      .read(routeProvider)
                                                      .changePage(context, 
                                                          "/confirm_payment");
                                                });

                                                  });
    
                                            },
                                        ),
                                      ]),
                                ),
                              ))
                            : Expanded(
                                child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: RichText(
                                  softWrap: true,
                                  text: TextSpan(
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0XFF4f4f4f),
                                          fontWeight: FontWeight.w400),
                                      children: [
                                        TextSpan(
                                          text: ref
                                              .watch(activityProvider)
                                              .activities[index]
                                              .name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: " just ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ref
                                                      .watch(activityProvider)
                                                      .activities[index]
                                                      .status ==
                                                  "CONFIRMED"
                                              ? "confirmed "
                                              : "denied",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ref
                                                        .watch(activityProvider)
                                                        .activities[index]
                                                        .status ==
                                                    "CONFIRMED"
                                                ? const Color(0xFF4F9A99)
                                                : const Color(0XFFF10D0D),
                                          ),
                                        ),
                                        const TextSpan(
                                          text: "Your payment of ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              "Rp.${formatNumber(ref.watch(activityProvider).activities[index].amount!)}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ref
                                                        .watch(activityProvider)
                                                        .activities[index]
                                                        .status ==
                                                    "CONFIRMED"
                                                ? const Color(0xFF4F9A99)
                                                : const Color(0XFFF10D0D),
                                          ),
                                        ),
                                        const TextSpan(
                                          text: " in ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ref
                                              .watch(activityProvider)
                                              .activities[index]
                                              .groupName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                ),
                              ))
                        : ref
                                    .watch(activityProvider)
                                    .activities[index]
                                    .activityType ==
                                "TRANSACTION"
                            ? Expanded(
                                child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: RichText(
                                  softWrap: true,
                                  text: TextSpan(
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0XFF4f4f4f),
                                          fontWeight: FontWeight.w400),
                                      children: [
                                        TextSpan(
                                          text: ref
                                              .watch(activityProvider)
                                              .activities[index]
                                              .name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: " just added transaction in ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ref
                                              .watch(activityProvider)
                                              .activities[index]
                                              .groupName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "\nView detail",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF4F9A99)),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              AddExpenseServices()
                                                  .getTransactionDetail(
                                                      ref,
                                                      ref
                                                          .watch(
                                                              activityProvider)
                                                          .activities[index]
                                                          .redirectId, context).then((value) {
                                                ref
                                                    .read(routeProvider)
                                                    .changePage(context, 
                                                        "/transaction_detail");

                                                          });
                                            },
                                        ),
                                      ]),
                                ),
                              ))
                            : Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0XFF4f4f4f),
                                          fontWeight: FontWeight.w400),
                                      children: [
                                        const TextSpan(
                                          text:
                                              "Don't forget to settle your payment to ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ref
                                              .watch(activityProvider)
                                              .activities[index]
                                              .name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: " in ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ref
                                              .watch(activityProvider)
                                              .activities[index]
                                              .groupName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                  ]),
            );
          },
        ))
      ]));
}
