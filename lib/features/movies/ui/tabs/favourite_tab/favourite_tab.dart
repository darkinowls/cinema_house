import 'package:cinema_house/features/movies/ui/tabs/top_charts_tab/vertical_movie_list_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale_keys.g.dart';
import '../../../../../ui/widgets/result_sign.dart';
import '../../../cubit/movies/movies_cubit.dart';

class FavouriteTab extends StatelessWidget {
  const FavouriteTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state.favouriteMovies.isEmpty) {
          return const ResultSign(
            iconData: Icons.favorite_border_outlined,
            text: "No favourite",
          );
        }
        return VerticalMovieListView(movies: state.favouriteMovies.values);
      },
    );
  }
}
