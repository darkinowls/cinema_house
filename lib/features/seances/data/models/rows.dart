import 'package:cinema_house/features/seances/data/models/seats.dart';

class Rows {
  Rows({
    required this.id,
    required this.index,
    required this.seats,
  });
  late final int id;
  late final int index;
  late final List<Seats> seats;

  Rows.fromJson(Map<String, dynamic> json){
    id = json['id'];
    index = json['index'];
    seats = List.from(json['seats']).map((e)=>Seats.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['index'] = index;
    _data['seats'] = seats.map((e)=>e.toJson()).toList();
    return _data;
  }
}