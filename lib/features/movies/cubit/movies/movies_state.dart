part of 'movies_cubit.dart';

@immutable
class MoviesState extends Equatable {
  final Status status;
  final Iterable<MovieEntity> searchedMovies;
  final Map<DateTime, Iterable<MovieEntity>> moviesByDay;
  final Iterable<MovieEntity> topMovies;
  final Iterable<MovieEntity> favouriteMovies;

  const MoviesState({
    this.status = Status.loading,
    this.searchedMovies = const [],
    this.topMovies = const [],
    this.moviesByDay = const {},
    this.favouriteMovies = const [],
  });

  MoviesState copyWith({
    Status? status,
    Iterable<MovieEntity>? searchedMovies,
    Map<DateTime, Iterable<MovieEntity>>? moviesByDay,
    Iterable<MovieEntity>? topMovies,
    Iterable<MovieEntity>? favouriteMovies,
  }) {
    return MoviesState(
      status: status ?? this.status,
      searchedMovies: searchedMovies ?? this.searchedMovies,
      moviesByDay: moviesByDay ?? this.moviesByDay,
      topMovies: topMovies ?? this.topMovies,
      favouriteMovies: favouriteMovies ?? this.favouriteMovies,
    );
  }

  @override
  List<Object> get props => [
        status,
        searchedMovies,
        moviesByDay,
        topMovies,
        favouriteMovies,
      ];
}
