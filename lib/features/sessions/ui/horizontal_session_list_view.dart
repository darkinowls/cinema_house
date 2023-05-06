import 'package:cinema_house/core/date_format_extention.dart';
import 'package:cinema_house/features/sessions/cubit/sessions/sessions_cubit.dart';
import 'package:cinema_house/features/sessions/ui/screens/session_details_screen/session_details_screen.dart';
import 'package:cinema_house/ui/widgets/loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/locale_keys.g.dart';
import '../../../core/locator.dart';
import '../cubit/session/session_cubit.dart';
import '../data/models/session.dart';
import '../domain/repositories/sessions_repository.dart';

class HorizontalSessionListView extends StatefulWidget {
  final Iterable<Session> sessions;

  const HorizontalSessionListView({super.key, required this.sessions});

  @override
  State<HorizontalSessionListView> createState() =>
      _HorizontalSessionListViewState();
}

class _HorizontalSessionListViewState extends State<HorizontalSessionListView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _scrollController.addListener(_scrollListener);
    _scrollController.addListener(_scrollTillEnd);
    super.didChangeDependencies();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      BlocProvider.of<SessionsCubit>(context).loadMoreSessions()
          .then((_) => _scrollController.addListener(_scrollTillEnd));
    }
  }

  void _scrollTillEnd() {
    if (_scrollController.position.pixels >
        _scrollController.position.maxScrollExtent - 200) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
      _scrollController.removeListener(_scrollTillEnd);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext outer) {
    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.all(15),
      scrollDirection: Axis.horizontal,
      itemCount: widget.sessions.length + 1,
      itemBuilder: (context, index) {
        if (index == widget.sessions.length) {
          return const Loader();
        }
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider<SessionCubit>(
                          create: (_) => SessionCubit(
                            widget.sessions.elementAt(index),
                            locator<SessionsRepository>()
                          ),
                          child: const SessionDetailsScreen(),
                        )));
          },
          borderRadius: BorderRadius.circular(15),
          child: Container(
              width: 275,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(LocaleKeys.room.tr(
                        args: [widget.sessions.elementAt(index).room.name])),
                    const SizedBox(height: 5),
                    Text(LocaleKeys.type
                        .tr(args: [widget.sessions.elementAt(index).type])),
                    const SizedBox(height: 5),
                    Text(widget.sessions
                        .elementAt(index)
                        .date
                        .formatDate(context.locale)),
                    const SizedBox(height: 5),
                    Text(widget.sessions.elementAt(index).date.formatTime()),
                    const SizedBox(height: 5),
                    Text(LocaleKeys.minimumPrice.tr(args: [
                      widget.sessions.elementAt(index).minPrice.toString()
                    ]))
                  ])),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(width: 10),
    );
  }
}
