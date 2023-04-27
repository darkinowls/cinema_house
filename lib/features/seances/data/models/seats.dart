class Seats {
  Seats({
    required this.id,
    required this.index,
    required this.type,
    required this.price,
    required this.isAvailable,
  });
  late final int id;
  late final int index;
  late final int type;
  late final int price;
  late final bool isAvailable;

  Seats.fromJson(Map<String, dynamic> json){
    id = json['id'];
    index = json['index'];
    type = json['type'];
    price = json['price'];
    isAvailable = json['isAvailable'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['index'] = index;
    _data['type'] = type;
    _data['price'] = price;
    _data['isAvailable'] = isAvailable;
    return _data;
  }
}