part of 'movie_cubit.dart';

class MovieState extends Equatable {
  final Movie movie;
  final Status status;

  MovieState copyWith({
    Movie? movie,
    Status? status,
  }) {
    return MovieState(
      movie: movie ?? this.movie,
      status: status ?? this.status,
    );
  }

  const MovieState({
    required this.movie,
    this.status = Status.loaded,
  });

  @override
  List<Object> get props => [movie, status];
}
