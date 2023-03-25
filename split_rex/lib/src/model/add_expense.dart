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
  bool selected;

  Items({
    this.name = "",
    this.qty = 0,
    this.price = 0,
    this.selected = false
  });
}

class Transaction {
  String name;
  String desc;
  int groupId;
  String date;
  int subtotal;
  int tax;
  int service;
  int total;
  int billOwner;
  List<Items> items = []; 

  Transaction({
    this.name = "",
    this.desc = "",
    this.groupId = -1,
    this.date = "",
    this.subtotal = -1,
    this.tax = -1,
    this.service = -1,
    this.total = -1,
    this.billOwner = -1,
  });
}