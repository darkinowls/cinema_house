import 'package:hive/hive.dart';

import '../../data/tickets_api.dart';
import '../entities/ticket_entity.dart';

class TicketsRepository {
  final Box<TicketEntity> _ticketBox;

  final TicketsApi _ticketsApi;

  TicketsRepository(this._ticketBox, this._ticketsApi);

  Future<Iterable<TicketEntity>> getTickets(bool isNetwork) async {
    if (isNetwork) {
      await _ticketBox.clear();
      List<TicketEntity> unsortedTickets = await _ticketsApi.getTickets();
      await _ticketBox.addAll(
          unsortedTickets..sort((a, b) => b.dateTime.compareTo(a.dateTime)));
    }
    return _ticketBox.values;
  }
}
