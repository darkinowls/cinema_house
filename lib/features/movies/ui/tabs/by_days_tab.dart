import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/movies_cubit.dart';
import '../../data/models/movie.dart';
import 'widgets/horizontal_movie_list_view.dart';

class ByDaysTab extends StatelessWidget {
  const ByDaysTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 25),
          const Text("Today films", style: TextStyle(fontSize: 20)),
          SizedBox(
            height: 350,
            child: BlocBuilder<MoviesCubit, MoviesState>(
                builder: (_, state) =>
                    HorizontalMovieListView(movies: state.todayMovies)),
          ),
          const SizedBox(height: 10),
          const Text("Tomorrow films", style: TextStyle(fontSize: 20)),
          SizedBox(
            height: 350,
            child: BlocBuilder<MoviesCubit, MoviesState>(
                builder: (context, state) =>
                    HorizontalMovieListView(movies: state.tomorrowMovies)),
          ),
        ],
      ),
    );
  }
}
