import 'package:cinema_house/features/movies/data/movies_api.dart';

import '../data/models/movie.dart';

class MoviesRepository {
  final MoviesApi _moviesApi;

  MoviesRepository(this._moviesApi);

  Future<List<Movie>> getMovies() async {
    return _moviesApi.getMovies();
  }

  Future<Iterable<Movie>> getMoviesByDay(DateTime dateTime) async {
    return _moviesApi.getMoviesByDate(dateTime);
  }

  Future<Iterable<Movie>> getMoviesByPlot(String plot) async {
    return _moviesApi.getMoviesByPlot(plot);
  }

  Future<Movie> getMoviesById(int id) async{
    return _moviesApi.getMoviesById(id);
  }
}
