import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/status.dart';
import '../../../lang/cubit/lang/lang_cubit.dart';
import '../../../lang/cubit/translatable/translatable_cubit.dart';
import '../../repositories/entities/movie_entity.dart';
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
    final List<MovieEntity> movies = await _moviesRepository.getMovies();

    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(const Duration(days: 1));

    final Map<DateTime, Iterable<MovieEntity>> moviesByDay = {
      today: await _moviesRepository.getMoviesByDay(today),
      tomorrow: await _moviesRepository.getMoviesByDay(tomorrow),
    };

    final Iterable<MovieEntity> topMovies =
        _sortMoviesByRating(movies.toList());
    final Iterable<MovieEntity> favouriteMovies =
        _moviesRepository.getFavouriteMovies();

    emit(state.copyWith(
        status: Status.loaded,
        moviesByDay: moviesByDay,
        topMovies: topMovies,
        favouriteMovies: favouriteMovies));
  }

  Future<void> loadMoreMoviesByDate() async {
    DateTime lastDateTime = state.moviesByDay.keys.last.copyWith();

    DateTime next = lastDateTime.add(const Duration(days: 1));
    DateTime nextAfterNext = next.add(const Duration(days: 1));
    Map<DateTime, Iterable<MovieEntity>> map = {
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
    final Map<DateTime, Iterable<MovieEntity>> map = {
      dateTime: await _moviesRepository.getMoviesByDay(dateTime),
      next: await _moviesRepository.getMoviesByDay(next),
    };
    emit(state.copyWith(moviesByDay: {...map}, status: Status.loaded));
  }

  Iterable<MovieEntity> _sortMoviesByRating(List<MovieEntity> movies) {
    movies.sort((MovieEntity a, MovieEntity b) {
      double aRating = double.parse(a.rating);
      double bRating = double.parse(b.rating);
      return bRating.compareTo(aRating);
    });
    return movies.take(100);
  }

  void searchMovieByPlot(String plot) async {
    emit(state.copyWith(status: Status.loading));
    Iterable<MovieEntity> searchedMovies =
        await _moviesRepository.getMoviesByPlot(plot);
    emit(state.copyWith(status: Status.loaded, searchedMovies: searchedMovies));
  }

  void addToFavouriteMovies(MovieEntity movie) {
    _moviesRepository.addToFavourite(movie);
    emit(state.copyWith(favouriteMovies: [...state.favouriteMovies, movie]));
  }

  void removeFromFavouriteMovies(MovieEntity movie) async {
    Iterable<MovieEntity> fMovies = await _moviesRepository.removeFromFavourite(movie);
    emit(state.copyWith(favouriteMovies: [...fMovies]));
  }
}
