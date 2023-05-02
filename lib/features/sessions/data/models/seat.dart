import '../../domain/entities/seat_with_row.dart';

class Seat extends SeatEntity {
  Seat({
    required super.id,
    required super.index,
    required super.type,
    required super.price,
    required super.isAvailable,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
        id: json['id'],
        index: json['index'],
        type: json['type'],
        price: json['price'],
        isAvailable: json['isAvailable']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['index'] = index;
    data['type'] = type;
    data['price'] = price;
    data['isAvailable'] = isAvailable;
    return data;
  }
}
