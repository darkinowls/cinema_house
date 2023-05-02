import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../core/dio_client.dart';
import 'models/session.dart';

class SessionsApi {
  final DioClient _dioClient;
  final String _url = '/movies/sessions';

  SessionsApi(this._dioClient);

  Future<Iterable<Session>> getSessionsByMovieIdAndDate(
      int movieId, DateTime date) async {
    Map<String, dynamic> queryParameters = {
      "movieId": movieId,
      "date": DateFormat('yyyy-MM-dd').format(date)
    };
    final Response response =
        await _dioClient.dio.get(_url, queryParameters: queryParameters);
    return (response.data['data'] as List)
        .map((json) => Session.fromJson(json));
  }
}
