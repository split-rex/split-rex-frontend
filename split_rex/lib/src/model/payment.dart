class ConfirmationPayment {
  String paymentId;
  String userId;
  String name;
  int color;
  int totalPaid;

  ConfirmationPayment({
    this.paymentId = "",
    this.userId = "",
    this.name = "",
    this.color = 0,
    this.totalPaid = 0,
  });
}

class UnsettledPayment {
  String paymentId;
  String userId;
  String name;
  int color;
  int totalUnpaid;

  UnsettledPayment({
    this.paymentId = "",
    this.userId = "",
    this.name = "",
    this.color = 0,
    this.totalUnpaid = 0,
  });
}
