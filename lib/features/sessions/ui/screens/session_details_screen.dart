import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: room.rows
                            .map((row) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: row.seats
                                      .map((seat) => SeatCheckBox(
                                          seat: seat..rowIndex = row.index))
                                      .toList(),
                                ))
                            .toList()),
                  ),
                ],
              ),
            ),
            BlocBuilder<SeatsCubit, SeatsState>(
              builder: (context, state) {
                bool notEmpty = state.seats.isNotEmpty;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: notEmpty ? 125 : 75,
                  color: Colors.black12,
                  child: Column(children: [
                    ListTile(
                      // title: const Text("Pick seats to book"),
                      trailing: ElevatedButton(
                        onPressed: notEmpty ? () {} : null,
                        child: const Text("Submit"),
                      ),
                      title: AnimatedDefaultTextStyle(
                          style: notEmpty
                              ? TextStyle(fontSize: 18, color:Theme.of(context).focusColor)
                              : TextStyle(fontSize: 16, color:Theme.of(context).focusColor),
                          duration: const Duration(milliseconds: 250),
                          child: notEmpty
                              ? Text(state.toTotalPrice())
                              : const Text("Pick seats to book")),

                      subtitle: notEmpty
                          ? Text(state.toRowsAndSeats().first)
                          : const Text(""),
                    ),
                  ]),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
