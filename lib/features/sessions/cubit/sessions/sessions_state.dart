part of 'sessions_cubit.dart';

class SessionsState extends Equatable {
  final Status status;
  final Iterable<Session> sessions;
  final int movieId;

  const SessionsState(
      {this.status = Status.loading,
      required this.movieId,
      this.sessions = const []});

  @override
  List<Object> get props => [status, sessions, movieId];

  SessionsState copyWith({
    Status? status,
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
