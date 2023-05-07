import 'package:cinema_house/features/movies/repositories/movies_repository.dart';
import 'package:cinema_house/ui/widgets/loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/locale_keys.g.dart';
import '../../../../core/locator.dart';
import '../../../../core/status.dart';
import '../../../../features/lang/cubit/lang/lang_cubit.dart';
import '../../../../features/movies/cubit/movies/movies_cubit.dart';
import '../../../../features/movies/ui/search_movie_delegate.dart';
import '../../../../features/movies/ui/tabs/by_days_tab/by_days_tab.dart';
import '../../../../features/movies/ui/tabs/favourite_tab/favourite_tab.dart';
import '../../../../features/movies/ui/tabs/top_charts_tab/top_charts_tab.dart';
import '../../../../features/network/widgets/no_network_sign.dart';

class MoviesTab extends StatelessWidget {
  const MoviesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return NoNetworkSign(
        elseChild: BlocProvider<MoviesCubit>(
            create: (context) => MoviesCubit(locator.getAsync<MoviesRepository>(),
                BlocProvider.of<LangCubit>(context)),
            child: DefaultTabController(
              length: 3,
              child: BlocBuilder<LangCubit, LangState>(
                builder: (context, state) {
                  return Scaffold(
                      appBar: AppBar(
                        title: Text(LocaleKeys.movies.tr()),
                        bottom: TabBar(
                          tabs: [
                            Tab(text: LocaleKeys.byDays.tr()),
                            Tab(text: LocaleKeys.topCharts.tr()),
                            Tab(text: LocaleKeys.favourite.tr() )
                          ],
                        ),
                        actions: [
                          IconButton(
                              onPressed: () => showSearch(
                                  context: context,
                                  delegate: SearchMovieDelegate(
                                      BlocProvider.of<MoviesCubit>(context))),
                              icon: const Icon(Icons.search)),
                          SizedBox(width: 10),
                        ],
                      ),
                      body: BlocBuilder<MoviesCubit, MoviesState>(
                        builder: (_, state) {
                          if (state.status == Status.loading) {
                            return const Loader();
                          }
                          return const TabBarView(
                            children: [
                              ByDaysTab(),
                              TopChartsTab(),
                              FavouriteTab()
                            ],
                          );
                        },
                      ));
                },
              ),
            )));
  }
}
