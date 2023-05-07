import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/status.dart';
import '../../../lang/cubit/lang/lang_cubit.dart';
import '../../../lang/cubit/translatable/translatable_cubit.dart';
import '../../repositories/entities/movie_entity.dart';
import '../../repositories/movies_repository.dart';

part 'movies_state.dart';

class MoviesCubit extends TranslatableCubit<MoviesState> {
  final Future<MoviesRepository> futureMoviesRepo;

  MoviesCubit(this.futureMoviesRepo, LangCubit langCubit)
      : super(initialState: const MoviesState(), langCubit: langCubit) {
    langCubit.stream.listen((event) => initLoad());
    initLoad();
  }

  Future<void> initLoad() async {
    MoviesRepository moviesRepository = await futureMoviesRepo;
    final List<MovieEntity> movies = await moviesRepository.getMovies();

    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(const Duration(days: 1));

    final Map<DateTime, Iterable<MovieEntity>> moviesByDay = {
      today: await moviesRepository.getMoviesByDay(today),
      tomorrow: await moviesRepository.getMoviesByDay(tomorrow),
    };

    final Iterable<MovieEntity> topMovies =
        _sortMoviesByRating(movies.toList());
    final Map<int , MovieEntity> favouriteMovies =
        await moviesRepository.getFavouriteMovies();

    emit(state.copyWith(
        status: Status.loaded,
        moviesByDay: moviesByDay,
        topMovies: topMovies,
        favouriteMovies: favouriteMovies));
  }

  Future<void> loadMoreMoviesByDate() async {
    MoviesRepository moviesRepository = await futureMoviesRepo;
    DateTime lastDateTime = state.moviesByDay.keys.last.copyWith();

    DateTime next = lastDateTime.add(const Duration(days: 1));
    DateTime nextAfterNext = next.add(const Duration(days: 1));
    Map<DateTime, Iterable<MovieEntity>> map = {
      next: await moviesRepository.getMoviesByDay(next),
      nextAfterNext: await moviesRepository.getMoviesByDay(nextAfterNext)
    };

    emit(state.copyWith(moviesByDay: {...state.moviesByDay, ...map}));
  }

  void loadByDate(DateTime? dateTime) async {
    if (dateTime == null) {
      return;
    }
    MoviesRepository moviesRepository = await futureMoviesRepo;
    emit(state.copyWith(status: Status.loading));
    DateTime next = dateTime.add(const Duration(days: 1));
    final Map<DateTime, Iterable<MovieEntity>> map = {
      dateTime: await moviesRepository.getMoviesByDay(dateTime),
      next: await moviesRepository.getMoviesByDay(next),
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
    MoviesRepository moviesRepository = await futureMoviesRepo;
    emit(state.copyWith(status: Status.loading));
    Iterable<MovieEntity> searchedMovies =
        await moviesRepository.getMoviesByPlot(plot);
    emit(state.copyWith(status: Status.loaded, searchedMovies: searchedMovies));
  }

  void addToFavouriteMovies(MovieEntity movie) async {
    MoviesRepository moviesRepository = await futureMoviesRepo;
    await moviesRepository.addToFavourite(movie);
    state.favouriteMovies[movie.id] = movie;
    emit(state.copyWith(favouriteMovies: {...state.favouriteMovies}));
  }

  void removeFromFavouriteMovies(MovieEntity movie) async {
    MoviesRepository moviesRepository = await futureMoviesRepo;
    moviesRepository.removeFromFavourite(movie);
    state.favouriteMovies.remove(movie.id);
    emit(state.copyWith(favouriteMovies: {...state.favouriteMovies}));
  }
}
