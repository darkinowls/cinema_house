part of 'movie_cubit.dart';

class MovieState extends Equatable {
  final MovieEntity movie;
  final bool isFavourite;
  final Status status;

  MovieState copyWith({
    MovieEntity? movie,
    bool? isFavourite,
    Status? status,
  }) {
    return MovieState(
      movie: movie ?? this.movie,
      isFavourite: isFavourite ?? this.isFavourite,
      status: status ?? this.status,
    );
  }

  const MovieState({
    required this.movie,
    this.isFavourite = false,
    this.status = Status.loaded,
  });

  @override
  List<Object> get props => [movie, isFavourite, status];
}
