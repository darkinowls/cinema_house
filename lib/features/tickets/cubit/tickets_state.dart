part of 'tickets_cubit.dart';

enum TicketsStatus { loading, loaded }

@immutable
class TicketsState extends Equatable {
  final TicketsStatus status;
  final Iterable<TicketEntity> tickets;

  const TicketsState(
      {this.status = TicketsStatus.loading, this.tickets = const []});

  TicketsState copyWith({
    TicketsStatus? status,
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
