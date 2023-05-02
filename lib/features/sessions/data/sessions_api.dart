import 'dart:convert';

import 'package:cinema_house/features/sessions/data/models/buy_seats.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../core/dio_client.dart';
import 'models/book_seats.dart';
import 'models/seat.dart';
import 'models/session.dart';

class SessionsApi {
  final DioClient _dioClient;
  final String _url = '/movies';

  SessionsApi(this._dioClient);

  Future<Iterable<Session>> getSessionsByMovieIdAndDate(
      int movieId, DateTime date) async {
    Map<String, dynamic> queryParameters = {
      "movieId": movieId,
      "date": DateFormat('yyyy-MM-dd').format(date)
    };
    final Response response = await _dioClient.dio
        .get("$_url/sessions", queryParameters: queryParameters);
    return (response.data['data'] as List)
        .map((json) => Session.fromJson(json));
  }

  Future<Session> getSessionById(int sessionId) async {
    final Response response = await _dioClient.dio
        .get("$_url/sessions/$sessionId");
    return Session.fromJson(response.data['data']);
  }

  Future<bool> bookSeats(BookSeats bookSeats) async {
    final Response response =
        await _dioClient.dio.post("$_url/book", data: jsonEncode(bookSeats));
    return response.data['success'];
  }

  Future<bool> buySeats(BuySeats buySeats) async {
    final Response response =
        await _dioClient.dio.post("$_url/buy", data: jsonEncode(buySeats));
    return response.data['success'];
  }
}
