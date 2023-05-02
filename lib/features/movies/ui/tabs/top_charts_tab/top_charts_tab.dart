import 'package:cinema_house/features/movies/ui/tabs/top_charts_tab/vertical_movie_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/movies_cubit.dart';

class TopChartsTab extends StatelessWidget {
  const TopChartsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        return VerticalMovieListView(movies: state.topMovies, showCounter: true);
      },
    );
  }
}
