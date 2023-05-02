part of 'sessions_cubit.dart';

enum SessionsStatus { init, loading, failed, success }

class SessionsState extends Equatable {
  final SessionsStatus status;
  final Iterable<Session> sessions;
  final int movieId;

  const SessionsState(
      {this.status = SessionsStatus.init,
      required this.movieId,
      this.sessions = const []});

  @override
  List<Object> get props => [status, sessions, movieId];

  SessionsState copyWith({
    SessionsStatus? status,
    Iterable<Session>? sessions,
    int? movieId,
  }) {
    return SessionsState(
      status: status ?? this.status,
      sessions: sessions ?? this.sessions,
      movieId: movieId ?? this.movieId,
    );
  }
}
