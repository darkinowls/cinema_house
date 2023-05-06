import 'package:cinema_house/features/movies/ui/tabs/top_charts_tab/vertical_movie_list_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale_keys.g.dart';
import '../../../../../ui/widgets/result_sign.dart';
import '../../../cubit/movies/movies_cubit.dart';

class TopChartsTab extends StatelessWidget {
  const TopChartsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state.topMovies.isEmpty) {
          return ResultSign(
            iconData: Icons.error,
            text: LocaleKeys.noMovies.tr(),
          );
        }
        return VerticalMovieListView(movies: state.topMovies, showCounter: true);
      },
    );
  }
}
