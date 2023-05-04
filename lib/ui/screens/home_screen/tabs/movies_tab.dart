import 'package:cinema_house/features/movies/repositories/movies_repository.dart';
import 'package:cinema_house/ui/widgets/loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/locale_keys.g.dart';
import '../../../../core/locator.dart';
import '../../../../features/movies/cubit/movies_cubit.dart';
import '../../../../features/movies/ui/search_movie_delegate.dart';
import '../../../../features/movies/ui/tabs/by_days_tab/by_days_tab.dart';
import '../../../../features/movies/ui/tabs/top_charts_tab/top_charts_tab.dart';
import '../../../../features/network/widgets/no_network_sign.dart';

class MoviesTab extends StatelessWidget {
  const MoviesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return NoNetworkSign(
        elseChild: BlocProvider<MoviesCubit>(
      create: (context) => MoviesCubit(locator<MoviesRepository>()),
      child: Builder(builder: (context) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                title: Text(LocaleKeys.movies.tr()),
                bottom: TabBar(
                  tabs: [
                    Tab(text: LocaleKeys.byDays.tr() ),
                    Tab(text: LocaleKeys.topCharts.tr()),
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () => showSearch(
                          context: context,
                          delegate: SearchMovieDelegate(
                              BlocProvider.of<MoviesCubit>(context))),
                      icon: const Icon(Icons.search))
                ],
              ),
              body: BlocBuilder<MoviesCubit, MoviesState>(
                builder: (_, state) {
                  if (state.status == MoviesStatus.loading) {
                    return const Loader();
                  }
                  return const TabBarView(
                    children: [
                      ByDaysTab(),
                      TopChartsTab(),
                    ],
                  );
                },
              )),
        );
      }),
    ));
  }
}


