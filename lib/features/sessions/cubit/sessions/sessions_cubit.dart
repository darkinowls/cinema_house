import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/status.dart';
import '../../data/models/session.dart';
import '../../domain/repositories/sessions_repository.dart';

part 'sessions_state.dart';

class SessionsCubit extends Cubit<SessionsState> {
  final SessionsRepository _sessionsRepository;

  SessionsCubit(this._sessionsRepository, int movieId)
      : super(SessionsState(movieId: movieId)) {
    _initLoad();
  }

  void _initLoad() async {
    _loadNewSessions(DateTime.now());
    emit(state.copyWith(status: Status.loaded));
  }

  void loadMoreSessions() async {
    DateTime lastDateTime =
        state.sessions.last.date.add(const Duration(days: 1));
    await _loadNewSessions(lastDateTime);
  }

  Future<void> _loadNewSessions(DateTime lastDateTime) async {
    DateTime next = lastDateTime;
    DateTime nextAfterNext = next.add(const Duration(days: 1));

    Iterable<Session> nextSessions = await _sessionsRepository
        .getSessionsByMovieIdAndDate(state.movieId, next);

    Iterable<Session> nextAfterNextSessions = await _sessionsRepository
        .getSessionsByMovieIdAndDate(state.movieId, nextAfterNext);

    emit(state.copyWith(sessions: [
      ...state.sessions,
      ...nextSessions,
      ...nextAfterNextSessions
    ]));
  }
}
