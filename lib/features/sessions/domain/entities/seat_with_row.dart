class SeatEntity {
  SeatEntity({
    required this.id,
    required this.index,
    required this.type,
    required this.price,
    required this.isAvailable,
  });

  final int id;
  final int index;
  final int type;
  final int price;
  final bool isAvailable;
  late int? rowIndex;
}
