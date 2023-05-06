import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../lang/cubit/lang/lang_cubit.dart';
import '../../../lang/cubit/translatable/translatable_cubit.dart';
import '../../data/models/movie.dart';
import '../../repositories/movies_repository.dart';

part 'movies_state.dart';

class MoviesCubit extends TranslatableCubit<MoviesState> {
  final MoviesRepository _moviesRepository;

  MoviesCubit(this._moviesRepository, LangCubit langCubit)
      : super(initialState: const MoviesState(), langCubit: langCubit) {
    langSubscription = langCubit.stream.listen((event) => initLoad());
    initLoad();
  }

  Future<void> initLoad() async {
    final List<Movie> movies = await _moviesRepository.getMovies();

    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(const Duration(days: 1));

    final Map<DateTime, Iterable<Movie>> moviesByDay = {
      today: await _moviesRepository.getMoviesByDay(today),
      tomorrow: await _moviesRepository.getMoviesByDay(tomorrow),
    };

    final Iterable<Movie> topMovies = _sortMoviesByRating(movies.toList());

    emit(state.copyWith(
        status: Status.loaded, moviesByDay: moviesByDay, topMovies: topMovies));
  }

  Future<void> loadMoreMoviesByDate() async {
    DateTime lastDateTime = state.moviesByDay.keys.last.copyWith();

    DateTime next = lastDateTime.add(const Duration(days: 1));
    DateTime nextAfterNext = next.add(const Duration(days: 1));
    Map<DateTime, Iterable<Movie>> map = {
      next: await _moviesRepository.getMoviesByDay(next),
      nextAfterNext: await _moviesRepository.getMoviesByDay(nextAfterNext)
    };

    emit(state.copyWith(moviesByDay: {...state.moviesByDay, ...map}));
  }

  void loadByDate(DateTime? dateTime) async {
    if (dateTime == null) {
      return;
    }
    emit(state.copyWith(status: Status.loading));
    DateTime next = dateTime.add(const Duration(days: 1));
    final Map<DateTime, Iterable<Movie>> map = {
      dateTime: await _moviesRepository.getMoviesByDay(dateTime),
      next: await _moviesRepository.getMoviesByDay(next),
    };
    emit(state.copyWith(moviesByDay: {...map}, status: Status.loaded));
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
    emit(state.copyWith(status: Status.loading));
    Iterable<Movie> searchedMovies =
        await _moviesRepository.getMoviesByPlot(plot);
    emit(state.copyWith(status: Status.loaded, searchedMovies: searchedMovies));
  }
}
