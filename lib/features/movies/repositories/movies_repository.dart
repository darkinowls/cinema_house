import 'package:cinema_house/features/movies/data/movies_api.dart';
import 'package:hive/hive.dart';

import 'entities/movie_entity.dart';

class MoviesRepository {
  final MoviesApi _moviesApi;
  final Box<int> favouriteMovieIds;

  MoviesRepository(this._moviesApi, this.favouriteMovieIds);

  Future<List<MovieEntity>> getMovies() async {
    return _moviesApi.getMovies();
  }

  Future<MovieEntity> addToFavourite(MovieEntity movie) async {
    await favouriteMovieIds.put(movie.id, movie.id);
    return getMoviesById(movie.id);
  }

  Future<void> removeFromFavourite(MovieEntity movie) async {
    await favouriteMovieIds.delete(movie.id);
  }

  bool checkIsFavourite(MovieEntity movie) {
    return favouriteMovieIds.containsKey(movie.id);
  }

  Future<Map<int, MovieEntity>> getFavouriteMovies() async {
    Map<int, MovieEntity> favourite = {};
    for (int id in favouriteMovieIds.values) {
      favourite[id] = await getMoviesById(id);
    }
    return favourite;
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
