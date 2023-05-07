import 'package:cinema_house/features/lang/cubit/lang/lang_cubit.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/status.dart';
import '../../../lang/cubit/translatable/translatable_cubit.dart';
import '../../repositories/entities/movie_entity.dart';
import '../../repositories/movies_repository.dart';
import '../movies/movies_cubit.dart';

part 'movie_state.dart';

class MovieCubit extends TranslatableCubit<MovieState> {
  final MoviesRepository moviesRepository;
  final MoviesCubit moviesCubit;

  MovieCubit(
      {required this.moviesCubit,
      required MovieEntity movie,
      required this.moviesRepository,
      required LangCubit langCubit})
      : super(
            initialState: MovieState(
                movie: movie,
                isFavourite: moviesRepository.checkIsFavourite(movie)),
            langCubit: langCubit) {
    langSubscription = langCubit.stream.listen((_) => updateMovie());
  }

  Future<void> updateMovie() async {
    MovieEntity movie = await moviesRepository.getMoviesById(state.movie.id);
    emit(state.copyWith(movie: movie));
  }

  void toggleIsFavourite() {
    if (state.isFavourite) {
      moviesCubit.removeFromFavouriteMovies(state.movie);
      emit(state.copyWith(isFavourite: false));
      return;
    }
    moviesCubit.addToFavouriteMovies(state.movie);
    emit(state.copyWith(isFavourite: true));
  }
}
