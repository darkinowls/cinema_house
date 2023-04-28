import 'package:cinema_house/core/date_format_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ui/widgets/loader.dart';
import '../../cubit/movies_cubit.dart';
import 'widgets/horizontal_movie_list_view.dart';

class ByDaysTab extends StatefulWidget {
  const ByDaysTab({Key? key}) : super(key: key);

  @override
  State<ByDaysTab> createState() => _ByDaysTabState();
}

class _ByDaysTabState extends State<ByDaysTab> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _scrollController.addListener(_scrollListener);
    super.didChangeDependencies();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      BlocProvider.of<MoviesCubit>(context).loadMoreMoviesByDate();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
        builder: (_, state) => ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 25),
            itemCount: state.moviesByDay.length,
            itemBuilder: (context, index) => Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(state.moviesByDay.keys.elementAt(index).formatDate(),
                        style: const TextStyle(fontSize: 16)),
                    SizedBox(
                        height: 350,
                        child: HorizontalMovieListView(
                            movies: state.moviesByDay.values.elementAt(index))),
                    if (index == state.moviesByDay.length - 1) const Loader()
                  ],
                )));
  }
}
