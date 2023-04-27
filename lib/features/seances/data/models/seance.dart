import 'package:cinema_house/features/seances/data/models/room.dart';

class Seance {
  Seance({
    required this.id,
    required this.date,
    required this.type,
    required this.minPrice,
    required this.room,
  });

  late final int id;
  late final int date;
  late final String type;
  late final int minPrice;
  late final Room room;

  Seance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    type = json['type'];
    minPrice = json['minPrice'];
    room = Room.fromJson(json['room']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['date'] = date;
    _data['type'] = type;
    _data['minPrice'] = minPrice;
    _data['room'] = room.toJson();
    return _data;
  }
}
