part of 'session_cubit.dart';

class SessionState extends Equatable {
  final Status status;
  final Session session;
  final Map<int, SeatEntity> seats;

  const SessionState(
      {required this.session,
      this.status = Status.loaded,
      this.seats = const {}});

  int getTotalPrice() {
    final int totalPrice = seats.values
        .map((e) => e.price)
        .reduce((value, element) => value + element);
    return totalPrice;
  }

  @override
  List<Object> get props => [status, session, seats];

  SessionState copyWith({
    Status? status,
    Session? session,
    Map<int, SeatEntity>? seats,
  }) {
    return SessionState(
      status: status ?? this.status,
      session: session ?? this.session,
      seats: seats ?? this.seats,
    );
  }
}
