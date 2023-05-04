import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/status.dart';
import '../../data/models/movie.dart';
import '../../repositories/movies_repository.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MoviesRepository _moviesRepository;

  MovieCubit(Movie movie, this._moviesRepository)
      : super(MovieState(movie: movie));

  Future<void> updateMovie() async {
    Movie movie = await _moviesRepository.getMoviesById(state.movie.id);
    emit(state.copyWith(movie: movie));
  }
}
