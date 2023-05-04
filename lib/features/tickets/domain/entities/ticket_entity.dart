import 'package:hive/hive.dart';

part 'ticket_entity.g.dart';

@HiveType(typeId: 0)
class TicketEntity {
  @HiveField(0)
  late final int movieId;
  @HiveField(1)
  late final String name;
  @HiveField(2)
  late final DateTime dateTime;
  @HiveField(3)
  late final String image;
  @HiveField(4)
  late final String smallImage;
  @HiveField(5)
  late final int seatIndex;
  @HiveField(6)
  late final int rowIndex;
  @HiveField(7)
  late final String roomName;


  TicketEntity({
    required this.movieId,
    required this.name,
    required this.dateTime,
    required this.image,
    required this.smallImage,
    required this.seatIndex,
    required this.rowIndex,
    required this.roomName,
  });
}
