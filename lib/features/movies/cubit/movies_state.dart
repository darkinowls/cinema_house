part of 'movies_cubit.dart';

enum MoviesStatus { loading, loaded }

@immutable
class MoviesState extends Equatable {
  final MoviesStatus status;
  final Iterable<Movie> searchedMovies;
  final Iterable<Movie> todayMovies;
  final Iterable<Movie> tomorrowMovies;
  final Iterable<Movie> topMovies;

  const MoviesState({this.status = MoviesStatus.loading,
    this.searchedMovies = const [],
    this.topMovies = const [],
    this.todayMovies = const [],
    this.tomorrowMovies = const []});

  @override
  List<Object> get props =>
      [
        status,
        searchedMovies,
        todayMovies,
        tomorrowMovies,
        topMovies,
      ];

  MoviesState copyWith({
    MoviesStatus? status,
    Iterable<Movie>? searchedMovies,
    Iterable<Movie>? todayMovies,
    Iterable<Movie>? tomorrowMovies,
    Iterable<Movie>? topMovies,
  }) {
    return MoviesState(
      status: status ?? this.status,
      searchedMovies: searchedMovies ?? this.searchedMovies,
      todayMovies: todayMovies ?? this.todayMovies,
      tomorrowMovies: tomorrowMovies ?? this.tomorrowMovies,
      topMovies: topMovies ?? this.topMovies,
    );
  }
}
