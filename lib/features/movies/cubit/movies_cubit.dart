import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../data/models/movie.dart';
import '../repositories/movies_repository.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesRepository _moviesRepository;

  MoviesCubit(this._moviesRepository) : super(const MoviesState()) {
    _getMovies();
  }

  void _getMovies() async {
    final List<Movie> movies = await _moviesRepository.getMovies();

    final Iterable<Movie> todayMovies =
        await _moviesRepository.getMoviesToday();
    final Iterable<Movie> tomorrowMovies =
        await _moviesRepository.getMoviesTomorrow();

    final Iterable<Movie> topMovies = _sortMoviesByRating(movies.toList());

    emit(state.copyWith(
        status: MoviesStatus.loaded,
        tomorrowMovies: tomorrowMovies,
        todayMovies: todayMovies,
        topMovies: topMovies));
  }

  Iterable<Movie> _sortMoviesByRating(List<Movie> movies) {
    movies.sort((Movie a, Movie b) {
      double aRating = double.parse(a.rating);
      double bRating = double.parse(b.rating);
      return bRating.compareTo(aRating);
    });
    return movies.take(100);
  }

  void searchMovieByPlot(String plot) async {
    emit(state.copyWith(
      status: MoviesStatus.loading
    ));
   Iterable<Movie> searchedMovies = await _moviesRepository.getMoviesByPlot(plot);
   emit(state.copyWith(
     status: MoviesStatus.loaded,
     searchedMovies: searchedMovies
   ));
  }
}
