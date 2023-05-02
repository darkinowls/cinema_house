part of 'sessions_cubit.dart';

class SessionsState extends Equatable {
  final Iterable<Session> sessions;
  final int movieId;

  const SessionsState({ required this.movieId, this.sessions = const []});

  SessionsState copyWith({
    Iterable<Session>? sessions,
    int? movieId,
  }) {
    return SessionsState(
      sessions: sessions ?? this.sessions,
      movieId: movieId ?? this.movieId,
    );
  }

  @override
  List<Object> get props => [sessions, movieId];

}
