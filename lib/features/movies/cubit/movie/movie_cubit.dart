import 'package:bloc/bloc.dart';
import 'package:cinema_house/features/lang/cubit/lang/lang_cubit.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/status.dart';
import '../../../lang/cubit/translatable/translatable_cubit.dart';
import '../../data/models/movie.dart';
import '../../repositories/movies_repository.dart';

part 'movie_state.dart';

class MovieCubit extends TranslatableCubit<MovieState> {
  final MoviesRepository _moviesRepository;

  MovieCubit(Movie movie, this._moviesRepository, LangCubit langCubit)
      : super(initialState: MovieState(movie: movie), langCubit: langCubit){
    langSubscription = langCubit.stream.listen((_) => updateMovie());
  }

  Future<void> updateMovie() async {
    Movie movie = await _moviesRepository.getMoviesById(state.movie.id);
    emit(state.copyWith(movie: movie));
  }
}
