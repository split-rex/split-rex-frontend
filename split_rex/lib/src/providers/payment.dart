import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/payment.dart';

class PaymentProvider extends ChangeNotifier {
  List<ConfirmationPayment> unconfirmedPayments = [];
  List<UnsettledPayment> unsettledPayments = [];

 void addUnsettledPayment(UnsettledPayment payment) {
    unsettledPayments.add(payment);
    notifyListeners();
  }

  void removeUnsettledPayment(UnsettledPayment payment) {
    unsettledPayments.remove(payment);
    notifyListeners();
  }

  void clearUnsettledPayments() {
    unsettledPayments.clear();
    notifyListeners();
  }

  void addUnconfirmedPayment(ConfirmationPayment payment) {
    unconfirmedPayments.add(payment);
    notifyListeners();
  }

  void removeUnconfirmedPayment(ConfirmationPayment payment) {
    unconfirmedPayments.remove(payment);
    notifyListeners();
  }

  void clearUnconfirmedPayments() {
    unconfirmedPayments.clear();
    notifyListeners();
  }
}

final paymentProvider = ChangeNotifierProvider((ref) => PaymentProvider());
