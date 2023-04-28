import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_rex/src/model/payment.dart';

class PaymentProvider extends ChangeNotifier {
  List<ConfirmationPayment> unconfirmedPayments = [];
  ConfirmationPayment currUnconfirmedPayments = ConfirmationPayment();
  List<UnsettledPayment> unsettledPayments = [];
  UnsettledPayment currUnsettledPayment = UnsettledPayment();

  void resetAll() {
    unconfirmedPayments = [];
    currUnconfirmedPayments = ConfirmationPayment();
    unsettledPayments = [];
    currUnsettledPayment = UnsettledPayment();
  }

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

  void changeCurrUnsettledPayment(int index) {
    currUnsettledPayment = unsettledPayments[index];
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

  void changeCurrUnconfirmedPayment(int index) {
    currUnconfirmedPayments = unconfirmedPayments[index];
    notifyListeners();
  }
}

final paymentProvider = ChangeNotifierProvider((ref) => PaymentProvider());
