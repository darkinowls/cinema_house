part of 'seats_cubit.dart';

class SeatsState extends Equatable {
  final Map<int, SeatEntity> seats;

  const SeatsState({this.seats = const {}});

  @override
  List<Object> get props => [seats];

  SeatsState copyWith({
    Map<int, SeatEntity>? seats,
  }) {
    return SeatsState(
      seats: seats ?? this.seats,
    );
  }

  String toTotalPrice() {
    final int totalPrice = seats.values
        .map((e) => e.price)
        .reduce((value, element) => value + element);
    return "Total price: ${totalPrice.toString()} UAH";
  }

  List<String> toRowsAndSeats() {
    final List<String> places = seats.values
        .map((e) =>
            "Row: ${e.rowIndex.toString()} + Seat: ${e.index.toString()}")
        .toList();
    return places;
  }
}
