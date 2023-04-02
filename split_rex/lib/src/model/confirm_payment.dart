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
