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