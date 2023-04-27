import 'package:cinema_house/features/movies/data/movies_api.dart';

import '../data/models/movie.dart';

class MoviesRepository {
  final MoviesApi _moviesApi;

  MoviesRepository(this._moviesApi);

  Future<List<Movie>> getMovies() async {
    return _moviesApi.getMovies();
  }

  Future<Iterable<Movie>> getMoviesToday() async {
    return _moviesApi.getMoviesByDate(DateTime.now());
  }

  Future<Iterable<Movie>> getMoviesTomorrow() async {
    return _moviesApi
        .getMoviesByDate(DateTime.now().add(const Duration(days: 1)));
  }

  Future<Iterable<Movie>> getMoviesByPlot(String plot) async {
    return _moviesApi.getMoviesByPlot(plot);
  }
}
