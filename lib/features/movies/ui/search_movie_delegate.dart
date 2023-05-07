import 'package:cinema_house/features/movies/ui/tabs/top_charts_tab/vertical_movie_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/status.dart';
import '../../../ui/widgets/loader.dart';
import '../cubit/movies/movies_cubit.dart';

class SearchMovieDelegate extends SearchDelegate {
  MoviesCubit moviesCubit;

  SearchMovieDelegate(this.moviesCubit);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            }
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty){
      return ListView();
    }
    moviesCubit.searchMovieByPlot(query);
    return BlocBuilder<MoviesCubit, MoviesState>(
        bloc: moviesCubit,
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Loader();
          }
          return BlocProvider.value(
            value: moviesCubit,
            child: VerticalMovieListView(movies: state.searchedMovies),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView();
  }
}
