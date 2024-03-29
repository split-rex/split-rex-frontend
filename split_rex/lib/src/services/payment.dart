import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/payment.dart';

import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/widgets/groups/group_settings.dart';

import '../common/const.dart';
import '../providers/payment.dart';

class PaymentServices {
  String endpoint = getUrl();
  // String endpoint = "http://localhost:8080";

  Future<void> getUnsettledPayment(WidgetRef ref) async {
    String groupId = ref.watch(groupListProvider).currGroup.groupId;
    Response resp = await get(
        Uri.parse("$endpoint/getUnsettledPayment?group_id=$groupId"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ref.watch(authProvider).jwtToken}'
        });
    var data = jsonDecode(resp.body);
    logger.d(data["data"]);
    if (data["message"] == "SUCCESS") {
      ref.read(paymentProvider).clearUnsettledPayments();
      if (data["data"] != null) {
        try {
          for (var payment in data["data"]) {
            UnsettledPayment tempPayment = UnsettledPayment();
            tempPayment.paymentId = payment["payment_id"];
            tempPayment.userId = payment["user_id"];
            tempPayment.name = payment["fullname"];
            tempPayment.color = payment["color"];
            tempPayment.totalUnpaid = (payment["total_unpaid"]).round();
            ref.read(paymentProvider).addUnsettledPayment(tempPayment);
          }
        } catch (error) {
          logger.d(error);
        }
      }
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> getUnconfirmedPayment(WidgetRef ref) async {
    String groupId = ref.watch(groupListProvider).currGroup.groupId;
    Response resp = await get(Uri.parse("$endpoint/getUnconfirmedPayment?group_id=$groupId"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ref.watch(authProvider).jwtToken}'
        });
    var data = jsonDecode(resp.body);
    logger.d(data);
    if (data["message"] == "SUCCESS") {
      ref.read(paymentProvider).clearUnconfirmedPayments();
      if (data["data"] != null) {
        try {
          for (var payment in data["data"]) {
            ConfirmationPayment tempPayment = ConfirmationPayment();
            tempPayment.paymentId = payment["payment_id"];
            tempPayment.userId = payment["user_id"];
            tempPayment.name = payment["fullname"];
            tempPayment.color = payment["color"];
            tempPayment.totalPaid = payment["total_paid"];
            ref.read(paymentProvider).addUnconfirmedPayment(tempPayment);
          }
        } catch (error) {
          logger.d(error);
        }
      }
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> settlePaymentOwed(
      WidgetRef ref, String paymentId, int totalPaid, BuildContext context) async {
    Response resp = await post(Uri.parse("$endpoint/settlePaymentOwed"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ref.watch(authProvider).jwtToken}'
        },
        body: jsonEncode({
          "payment_id": paymentId,
          "total_paid": totalPaid,
        }));
    var data = jsonDecode(resp.body);
    logger.d(data);
    if (data["message"] == "SUCCESS") {
      if (context.mounted) {
        ref.read(routeProvider).changePage(context, "/group_detail");
      }
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> settlePaymentLent(
      WidgetRef ref, String paymentId, int totalPaid, BuildContext context) async {
    Response resp = await post(Uri.parse("$endpoint/settlePaymentLent"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ref.watch(authProvider).jwtToken}'
        },
        body: jsonEncode({
          "payment_id": paymentId,
          "total_paid": totalPaid,
        }));
    var data = jsonDecode(resp.body);
    logger.d(data);
    if (data["message"] == "SUCCESS") {
      if (context.mounted) {
        ref.read(routeProvider).changePage(context, "/group_detail");
      }
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> confirmSettle(WidgetRef ref, String paymentId) async {
    Response resp = await post(Uri.parse("$endpoint/confirmSettle"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ref.watch(authProvider).jwtToken}'
        },
        body: jsonEncode({
          "payment_id": paymentId,
        }));
    var data = jsonDecode(resp.body);
    logger.d(data);
    if (data["message"] == "SUCCESS") {
      await getUnconfirmedPayment(ref);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> denySettle(WidgetRef ref, String paymentId) async {
    Response resp = await post(Uri.parse("$endpoint/denySettle"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ref.watch(authProvider).jwtToken}'
        },
        body: jsonEncode({
          "payment_id": paymentId,
        }));
    var data = jsonDecode(resp.body);
    if (data["message"] == "SUCCESS") {
      await getUnconfirmedPayment(ref);
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }
}
