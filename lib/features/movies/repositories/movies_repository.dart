import 'package:cinema_house/features/movies/data/movies_api.dart';
import 'package:hive/hive.dart';

import 'entities/movie_entity.dart';

class MoviesRepository {
  final MoviesApi _moviesApi;
  final Box<int> _favouriteMovieIds;

  MoviesRepository(this._moviesApi, this._favouriteMovieIds);

  Future<List<MovieEntity>> getMovies() async {
    return _moviesApi.getMovies();
  }

  Future<MovieEntity> addToFavourite(MovieEntity movie) async {
    await _favouriteMovieIds.put(movie.id, movie.id);
    return movie;
  }

  Future<void> removeFromFavourite(MovieEntity movie) async {
    await _favouriteMovieIds.delete(movie.id);
  }

  bool checkIsFavourite(MovieEntity movie) {
    return _favouriteMovieIds.containsKey(movie.id);
  }

  Map<int, MovieEntity> getFavouriteFromAllMovies(
      Iterable<MovieEntity> movies) {
    return Map.fromIterable(
        movies.where((m) => _favouriteMovieIds.keys.contains(m.id)),
        key: (m) => m.id);
  }

  Future<Iterable<MovieEntity>> getMoviesByDay(DateTime dateTime) async {
    return _moviesApi.getMoviesByDate(dateTime);
  }

  Future<Iterable<MovieEntity>> getMoviesByPlot(String plot) async {
    return _moviesApi.getMoviesByPlot(plot);
  }

  Future<MovieEntity> getMoviesById(int id) async {
    return _moviesApi.getMoviesById(id);
  }
}
