import 'package:dio/dio.dart';

import '../../../core/dio_client.dart';
import 'models/ticket_model.dart';

class TicketsApi {
  final DioClient _dioClient;
  final String _ticketsUrl = '/user/tickets';

  TicketsApi(this._dioClient);

  Future<List<TicketModel>> getTickets() async {
    final Response response = await _dioClient.dio.get(_ticketsUrl);
    return (response.data['data'] as List)
        .map((json) => TicketModel.fromJson(json))
        .toList();
  }
}
