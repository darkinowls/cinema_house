import 'package:cinema_house/features/tickets/domain/entities/ticket_entity.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class TicketModel extends TicketEntity {
  late int id;

  TicketModel({
    required this.id,
    required super.movieId,
    required super.name,
    required super.dateTime,
    required super.image,
    required super.smallImage,
    required super.seatIndex,
    required super.rowIndex,
    required super.roomName,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
        id: json['id'],
        movieId: json['movieId'],
        name: json['name'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000),
        image: json['image'],
        smallImage: json['smallImage'],
        seatIndex: json['seatIndex'],
        rowIndex: json['rowIndex'],
        roomName: json['roomName']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['movieId'] = movieId;
    data['name'] = name;
    data['date'] = dateTime.millisecondsSinceEpoch;
    data['image'] = image;
    data['smallImage'] = smallImage;
    data['seatIndex'] = seatIndex;
    data['rowIndex'] = rowIndex;
    data['roomName'] = roomName;
    return data;
  }
}
