import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/confirm_payment.dart';

class PaymentProvider extends ChangeNotifier {
  List<ConfirmationPayment> unconfirmedPayments = [];

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
