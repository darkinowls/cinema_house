import 'package:cinema_house/features/movies/ui/screens/movie_details_screen.dart';
import 'package:cinema_house/features/movies/ui/tabs/top_charts_tab/vertical_movie_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/widgets/loader.dart';
import '../cubit/movies_cubit.dart';

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
    moviesCubit.searchMovieByPlot(query);
    return BlocBuilder<MoviesCubit, MoviesState>(
        bloc: moviesCubit,
        builder: (context, state) {
          if (state.status == MoviesStatus.loading) {
            return const Loader();
          }
          return VerticalMovieListView(movies: state.searchedMovies);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView();
  }
}
