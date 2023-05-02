import 'package:cinema_house/features/sessions/data/models/row.dart';

class Room {
  Room({
    required this.id,
    required this.name,
    required this.rows,
  });

  late final int id;
  late final String name;
  late final List<Row> rows;

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rows = List.from(json['rows']).map((e) => Row.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['rows'] = rows.map((e) => e.toJson()).toList();
    return data;
  }
}
