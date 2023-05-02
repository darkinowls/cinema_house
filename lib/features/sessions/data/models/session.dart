import 'package:cinema_house/features/sessions/data/models/room.dart';

class Session {
  Session({
    required this.id,
    required this.date,
    required this.type,
    required this.minPrice,
    required this.room,
  });

  late final int id;
  late final DateTime date;
  late final String type;
  late final int minPrice;
  late Room room;

  Session.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000);
    type = json['type'];
    minPrice = json['minPrice'];
    room = Room.fromJson(json['room']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date.millisecondsSinceEpoch;
    data['type'] = type;
    data['minPrice'] = minPrice;
    data['room'] = room.toJson();
    return data;
  }
}
