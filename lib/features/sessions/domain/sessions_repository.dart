import '../data/models/session.dart';
import '../data/sessions_api.dart';

class SessionsRepository {
  final SessionsApi _sessionsApi;

  SessionsRepository(this._sessionsApi);

  Future<Iterable<Session>> getSessionsByMovieIdAndDate(
      int movieId, DateTime date) async {
    return _sessionsApi.getSessionsByMovieIdAndDate(movieId, date);
  }
}
