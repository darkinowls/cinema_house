import 'package:cinema_house/features/sessions/data/models/session.dart';
import 'package:cinema_house/ui/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../cubit/seats/seats_cubit.dart';
import 'seat_check_box.dart';

class SessionDetailsScreen extends StatelessWidget {
  final Session session;

  const SessionDetailsScreen({Key? key, required this.session})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(session.room.name),
          actions: [
            IconButton(
                onPressed: () async => BlocProvider.of<SeatsCubit>(context)
                    .updateSession(session.id),
                icon: const Icon(Icons.update))
          ],
        ),
        body: BlocBuilder<SeatsCubit, SeatsState>(
          builder: (context, state) {
            if (state.status == SeatsStatus.loading) {
              print("Loading");
              return const Loader();
            }
            if (state.status == SeatsStatus.failed) {
              return const Center(
                  child: Text("Someone else has just booked the seats"));
            }
            bool notEmpty = state.seats.isNotEmpty;
            List<String> items = state.toRowsAndSeats();
            return SlidingUpPanel(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          Container(
                            height: 10,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 7),
                                  )
                                ]),
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            height: 300,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: session.room.rows
                                    .map((row) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: row.seats
                                              .map((seat) => SeatCheckBox(
                                                  seat: seat
                                                    ..rowIndex = row.index))
                                              .toList(),
                                        ))
                                    .toList()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                isDraggable: (notEmpty) ? true : false,
                panel: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 6,
                          decoration: BoxDecoration(
                              color: (notEmpty)
                                  ? Theme.of(context).focusColor
                                  : Colors.grey,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListTile(
                        title: notEmpty
                            ? Text(state.toTotalPrice())
                            : const Text("Choose some seats above!"),
                        trailing: ElevatedButton(
                          onPressed: (notEmpty)
                              ? () async {
                                  BlocProvider.of<SeatsCubit>(context)
                                      .bookSeats(session.id);
                                }
                              : null,
                          child: const Text("Submit"),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Picked seats:", style: TextStyle(fontSize: 16)),
                    Expanded(
                        child: ListView.separated(
                      itemCount: items.length,
                      itemBuilder: (context, index) => Text(items[index]),
                      separatorBuilder: (_, __) => const SizedBox(height: 5),
                    ))
                  ]),
                ));
          },
        ));
  }
}
