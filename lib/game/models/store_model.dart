class StoreModel {
  String? type;
  String? color;
  int? price;
  bool? isUnlock;

  StoreModel({this.type, this.color, this.price, this.isUnlock});

  StoreModel.fromJson(Map<dynamic, dynamic> json) {
    type = json['type'];
    color = json['color'];
    price = json['price'];
    isUnlock = json['isUnlock'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['type'] = type;
    data['color'] = color;
    data['price'] = price;
    data['isUnlock'] = isUnlock;
    return data;
  }
}
