part of 'movies_cubit.dart';

enum MoviesStatus { loading, loaded }

@immutable
class MoviesState extends Equatable {
  final MoviesStatus status;
  final Iterable<Movie> searchedMovies;
  final Map<DateTime, Iterable<Movie>> moviesByDay;
  final Iterable<Movie> topMovies;

  const MoviesState({
    this.status = MoviesStatus.loading,
    this.searchedMovies = const [],
    this.topMovies = const [],
    this.moviesByDay = const {},
  });

  @override
  List<Object> get props => [
        status,
        searchedMovies,
        moviesByDay,
        topMovies,
      ];

  MoviesState copyWith({
    MoviesStatus? status,
    Iterable<Movie>? searchedMovies,
    Map<DateTime, Iterable<Movie>>? moviesByDay,
    Iterable<Movie>? topMovies,
  }) {
    return MoviesState(
      status: status ?? this.status,
      searchedMovies: searchedMovies ?? this.searchedMovies,
      moviesByDay: moviesByDay ?? this.moviesByDay,
      topMovies: topMovies ?? this.topMovies,
    );
  }
}
