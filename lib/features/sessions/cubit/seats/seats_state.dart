part of 'seats_cubit.dart';

enum SeatsStatus { init, loading, failed, success }

class SeatsState extends Equatable {
  final SeatsStatus status;
  final Map<int, SeatEntity> seats;

  const SeatsState({this.status = SeatsStatus.init, this.seats = const {}});

  @override
  List<Object> get props => [status, seats];

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

  SeatsState copyWith({
    SeatsStatus? status,
    Map<int, SeatEntity>? seats,
  }) {
    return SeatsState(
      status: status ?? this.status,
      seats: seats ?? this.seats,
    );
  }
}
