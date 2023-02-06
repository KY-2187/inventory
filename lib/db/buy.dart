class Buy {
  int? id;
  String? itemName;
  int? buyQuantity;
  String? location;
  String? price;
  String? date;

  Buy({
    this.id,
    this.itemName,
    this.buyQuantity,
    this.location,
    this.price,
    this.date,
  });

  Buy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['itemName'];
    buyQuantity = json['buyQuantity'];
    location = json['location'];
    price = json['price'];
    date = json['date'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemName'] = this.itemName;
    data['buyQuantity'] = this.buyQuantity;
    data['location'] = this.location;
    data['price'] = this.price;
    data['date'] = this.date;
    return data;
  }
}
