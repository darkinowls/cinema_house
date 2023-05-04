import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../data/models/movie.dart';
import '../repositories/movies_repository.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesRepository _moviesRepository;

  MoviesCubit(this._moviesRepository) : super(const MoviesState()) {
    init();
  }

  Future<void> init() async {
    final List<Movie> movies = await _moviesRepository.getMovies();

    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(const Duration(days: 1));

    final Map<DateTime, Iterable<Movie>> moviesByDay = {
      today: await _moviesRepository.getMoviesByDay(today),
      tomorrow: await _moviesRepository.getMoviesByDay(tomorrow),
    };

    final Iterable<Movie> topMovies = _sortMoviesByRating(movies.toList());

    emit(state.copyWith(
        status: MoviesStatus.loaded,
        moviesByDay: moviesByDay,
        topMovies: topMovies));
  }

  void loadMoreMoviesByDate() async {
    DateTime lastDateTime = state.moviesByDay.keys.last.copyWith();

    DateTime next = lastDateTime.add(const Duration(days: 1));
    DateTime nextAfterNext = next.add(const Duration(days: 1));
    Map<DateTime, Iterable<Movie>> map = {
      next: await _moviesRepository.getMoviesByDay(next),
      nextAfterNext: await _moviesRepository.getMoviesByDay(nextAfterNext)
    };

    emit(state.copyWith(moviesByDay: {...state.moviesByDay, ...map}));
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
    emit(state.copyWith(status: MoviesStatus.loading));
    Iterable<Movie> searchedMovies =
        await _moviesRepository.getMoviesByPlot(plot);
    emit(state.copyWith(
        status: MoviesStatus.loaded, searchedMovies: searchedMovies));
  }


  void getMoviesById() async{

  }
}
