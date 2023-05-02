import 'package:cinema_house/core/date_format_extention.dart';
import 'package:cinema_house/features/sessions/cubit/sessions/sessions_cubit.dart';
import 'package:cinema_house/features/sessions/ui/screens/session_details_screen/session_details_screen.dart';
import 'package:cinema_house/ui/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/locator.dart';
import '../cubit/seats/seats_cubit.dart';
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
    super.didChangeDependencies();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      BlocProvider.of<SessionsCubit>(context).loadMoreSessions();
    }
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
                    builder: (_) => BlocProvider.value(
                          value: SeatsCubit(
                              BlocProvider.of<SessionsCubit>(outer),
                              locator<SessionsRepository>()),
                          child: SessionDetailsScreen(
                              session: widget.sessions.elementAt(index)),
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
                    Text(
                        'Room: "${widget.sessions.elementAt(index).room.name}"'),
                    const SizedBox(height: 5),
                    Text("Type: ${widget.sessions.elementAt(index).type}"),
                    const SizedBox(height: 5),
                    Text(widget.sessions.elementAt(index).date.formatDate()),
                    const SizedBox(height: 5),
                    Text(widget.sessions.elementAt(index).date.formatTime()),
                    const SizedBox(height: 5),
                    Text(
                        "Minimum price: ${widget.sessions.elementAt(index).minPrice.toString()} UAH")
                  ])),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(width: 10),
    );
  }
}
