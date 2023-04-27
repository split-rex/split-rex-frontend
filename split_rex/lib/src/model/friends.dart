class Friend {
  String userId;
  String name;
  String username;
  int color;
  String email;
  late Map<String, Map<int, String>> paymentInfo;
  List<dynamic> flattenPaymentInfo = [];

  Friend({
    this.userId = "",
    this.name = "",
    this.username = "",
    this.color = 1,
    this.email = ""
  });
}
