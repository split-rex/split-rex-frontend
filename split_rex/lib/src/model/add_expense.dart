class NewGroup {
  String name;
  List<String> memberId = [];
  String startDate;
  String endDate;
  
  NewGroup({
    this.name = "",
    this.startDate = "",
    this.endDate = "",
  });
}

class Items {
  String name;
  int qty; 
  int price;
  int total;
  List<String> consumer = [];

  Items({
    this.name = "",
    this.qty = 0,
    this.price = 0,
    this.total = 0,
  });
}

class Transaction {
  String name;
  String desc;
  String groupId;
  String date = DateTime.now().toUtc().toIso8601String();
  int subtotal;
  int tax;
  int service;
  int total;
  String billOwner;
  List<Items> items = []; 

  Transaction({
    this.name = "",
    this.desc = "",
    this.groupId = "",
    this.subtotal = 0,
    this.tax = 0,
    this.service = 0,
    this.total = 0,
    this.billOwner = "",
  });
}