import 'package:split_rex/src/model/friends.dart';

class NewGroup {
  String name;
  List<String> memberId = [];
  String startDate;
  String endDate;
  
  NewGroup({
    this.name = "Group",
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
  List<Friend> consumerDetails = [];

  Items({
    this.name = "Item",
    this.qty = 0,
    this.price = 0,
    this.total = 0,
  });
}

class Transaction {
  String transactionId;
  String name;
  String desc;
  String groupId;
  String groupName;
  String date = DateTime.now().toUtc().toIso8601String();
  int subtotal;
  int tax;
  int service;
  int total;
  String billOwner;
  List<Items> items = []; 

  Transaction({
    this.transactionId = "",
    this.name = "Transaction",
    this.desc = "",
    this.groupId = "",
    this.groupName = "",
    this.subtotal = 0,
    this.tax = 0,
    this.service = 0,
    this.total = 0,
    this.billOwner = "",
  });
}
