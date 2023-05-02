import 'package:cinema_house/features/sessions/cubit/sessions/sessions_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../cubit/seats/seats_cubit.dart';
import '../../data/models/room.dart';
import '../seat_check_box.dart';

class SessionDetailsScreen extends StatelessWidget {
  final Room room;

  const SessionDetailsScreen({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SeatsCubit>(
      create: (context) => SeatsCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(room.name),
          ),
          body: BlocBuilder<SeatsCubit, SeatsState>(
            builder: (context, state) {
              bool notEmpty = state.seats.isNotEmpty;
              List<String> items = state.toRowsAndSeats();
              return SlidingUpPanel(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
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
                                  children: room.rows
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
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.9),
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
                            onPressed: (notEmpty) ? () {} : null,
                            child: const Text("Submit"),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Picked seats:",
                          style: TextStyle(fontSize: 16)),
                      Expanded(
                          child: ListView.separated(
                            itemCount: items.length,
                            itemBuilder: (context, index) => Text(items[index]),
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 5),
                          ))
                    ]),
                  ));
            },
          )),
    );
  }
}
