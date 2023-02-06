class Item {
  String? itemName;
  int? quantity;

  Item({this.itemName, this.quantity});

  Item.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    quantity = json['quantity'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['quantity'] = this.quantity;
    return data;
  }
}
