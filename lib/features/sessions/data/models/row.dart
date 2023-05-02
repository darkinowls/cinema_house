

import 'package:cinema_house/features/sessions/data/models/seat.dart';

class Row {
  Row({
    required this.id,
    required this.index,
    required this.seats,
  });
  late final int id;
  late final int index;
  late final List<Seat> seats;

  Row.fromJson(Map<String, dynamic> json){
    id = json['id'];
    index = json['index'];
    seats = List.from(json['seats']).map((e)=>Seat.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['index'] = index;
    data['seats'] = seats.map((e)=>e.toJson()).toList();
    return data;
  }
}