part of 'tickets_cubit.dart';

@immutable
class TicketsState extends Equatable {
  final Status status;
  final Iterable<TicketEntity> tickets;

  const TicketsState(
      {this.status = Status.loading, this.tickets = const []});

  TicketsState copyWith({
    Status? status,
    Iterable<TicketEntity>? tickets,
  }) {
    return TicketsState(
      status: status ?? this.status,
      tickets: tickets ?? this.tickets,
    );
  }

  @override
  List<Object> get props => [status, tickets];
}
