class Use {
  int? id;
  String? itemName;
  int? useQuantity;
  String? date;

  Use({
    this.id,
    this.itemName,
    this.useQuantity,
    this.date,
  });

  Use.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['itemName'];
    useQuantity = json['useQuantity'];
    date = json['date'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemName'] = this.itemName;
    data['useQuantity'] = this.useQuantity;
    data['date'] = this.date;
    return data;
  }
}
