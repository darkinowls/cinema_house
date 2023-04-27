import 'package:cinema_house/features/seances/data/models/rows.dart';

class Room {
  Room({
    required this.id,
    required this.name,
    required this.rows,
  });
  late final int id;
  late final String name;
  late final List<Rows> rows;

  Room.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    rows = List.from(json['rows']).map((e)=>Rows.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['rows'] = rows.map((e)=>e.toJson()).toList();
    return _data;
  }
}