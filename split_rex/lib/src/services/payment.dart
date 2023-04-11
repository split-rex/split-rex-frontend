import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/payment.dart';

import 'package:split_rex/src/providers/auth.dart';
import 'package:split_rex/src/providers/error.dart';
import 'package:split_rex/src/providers/group_list.dart';
import 'package:split_rex/src/providers/routes.dart';
import 'package:split_rex/src/widgets/groups/group_settings.dart';

import '../providers/payment.dart';

class PaymentServices {
  String endpoint = "https://split-rex-backend-7v6i6rndga-et.a.run.app";

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
      try {
        for (var data in data["data"]) {
          UnsettledPayment tempPayment = UnsettledPayment();
          tempPayment.paymentId = data["payment_id"];
          tempPayment.userId = data["user_id"];
          tempPayment.name = data["fullname"];
          tempPayment.color = data["color"];
          tempPayment.totalUnpaid = data["total_unpaid"];
          ref.read(paymentProvider).addUnsettledPayment(tempPayment);
        }
      } catch (error) {
        logger.d(error);
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
      try {
        for (var data in data["data"]) {
          ConfirmationPayment tempPayment = ConfirmationPayment();
          tempPayment.paymentId = data["payment_id"];
          tempPayment.userId = data["user_id"];
          tempPayment.name = data["fullname"];
          tempPayment.color = data["color"];
          tempPayment.totalPaid = data["total_paid"];
          ref.read(paymentProvider).addUnconfirmedPayment(tempPayment);
        }
      } catch (error) {
        logger.d(error);
      }
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> settlePaymentOwed(
      WidgetRef ref, String paymentId, int totalPaid) async {
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
      ref.read(routeProvider).changePage("group_detail");
    } else {
      ref.read(errorProvider).changeError(data["message"]);
    }
  }

  Future<void> settlePaymentLent(
      WidgetRef ref, String paymentId, int totalPaid) async {
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
      ref.read(routeProvider).changePage("group_detail");
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
