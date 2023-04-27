part of 'tickets_cubit.dart';

@immutable
abstract class TicketsState extends Equatable {
  final Iterable<TicketEntity> tickets;

  const TicketsState(this.tickets);

  @override
  List<Object> get props => [tickets];
}

class Loading extends TicketsState {
  Loading() : super([]);
}

class Loaded extends TicketsState {
  const Loaded(super.tickets);
}
