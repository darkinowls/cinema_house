import 'package:cinema_house/features/sessions/data/models/book_seats.dart';
import 'package:cinema_house/features/sessions/data/models/buy_seats.dart';
import 'package:cinema_house/features/sessions/domain/entities/card_form.dart';

import '../../data/models/seat.dart';
import '../../data/models/session.dart';
import '../../data/sessions_api.dart';

class SessionsRepository {
  final SessionsApi _sessionsApi;

  SessionsRepository(this._sessionsApi);

  Future<Iterable<Session>> getSessionsByMovieIdAndDate(
      int movieId, DateTime date) async {
    return _sessionsApi.getSessionsByMovieIdAndDate(movieId, date);
  }

  Future<Session> getSessionById(int sessionId){
    return _sessionsApi.getSessionById(sessionId);
  }


  Future<bool> bookSeats(Iterable<int> seats, int sessionId) async {
    final BookSeats bookSeats =
        BookSeats(seats: seats.toList(), sessionId: sessionId);
    return _sessionsApi.bookSeats(bookSeats);
  }

  Future<bool> buySeats(
      Iterable<int> seats, int sessionId, CardForm cardForm) async {
    final BuySeats buySeats =
        cardForm.toBuySeats(seats.toList(), sessionId);
    return _sessionsApi.buySeats(buySeats);
  }
}
