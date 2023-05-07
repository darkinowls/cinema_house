import 'package:cinema_house/features/movies/data/movies_api.dart';
import 'package:hive/hive.dart';

import 'entities/movie_entity.dart';

class MoviesRepository {
  final MoviesApi _moviesApi;
  final Box<MovieEntity> favouriteMovies;

  MoviesRepository(this._moviesApi, this.favouriteMovies);

  Future<List<MovieEntity>> getMovies() async {
    return _moviesApi.getMovies();
  }

  Future<Iterable<MovieEntity>> addToFavourite(MovieEntity movie) async {
    await favouriteMovies.put(movie.id, movie);
    return favouriteMovies.values;
  }

  Future<Iterable<MovieEntity>> removeFromFavourite(MovieEntity movie) async {
    await favouriteMovies.delete(movie.id);
    return getFavouriteMovies();
  }
  bool checkIsFavourite(MovieEntity movie) {
    return favouriteMovies.containsKey(movie.id);
  }

  Iterable<MovieEntity> getFavouriteMovies() {
    return favouriteMovies.values;
  }

  Future<Iterable<MovieEntity>> getMoviesByDay(DateTime dateTime) async {
    return _moviesApi.getMoviesByDate(dateTime);
  }

  Future<Iterable<MovieEntity>> getMoviesByPlot(String plot) async {
    return _moviesApi.getMoviesByPlot(plot);
  }

  Future<MovieEntity> getMoviesById(int id) async{
    return _moviesApi.getMoviesById(id);
  }
}
