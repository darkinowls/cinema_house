import 'package:cinema_house/core/locale_keys.g.dart';
import 'package:cinema_house/core/locator.dart';
import 'package:cinema_house/features/sessions/cubit/transactions/transaction_cubit.dart';
import 'package:cinema_house/features/sessions/data/models/session.dart';
import 'package:cinema_house/features/sessions/domain/entities/seat_with_row.dart';
import 'package:cinema_house/ui/widgets/loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../cubit/seats/seats_cubit.dart';
import '../../../domain/repositories/sessions_repository.dart';
import '../transaction_screen/transaction_screen.dart';
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
        ),
        body: BlocBuilder<SeatsCubit, SeatsState>(
          builder: (context, state) {
            if (state.status == SeatsStatus.loading) {
              return const Loader();
            }
            if (state.status == SeatsStatus.failed) {
              return Center(
                  child:
                      Text(LocaleKeys.someoneElseHasJustBookedTheSeats.tr()));
            }
            bool notEmpty = state.seats.isNotEmpty;
            Iterable<SeatEntity> seats = state.seats.values;
            return SlidingUpPanel(
                body: RefreshIndicator(
                  onRefresh: () async => BlocProvider.of<SeatsCubit>(context)
                      .updateSession(session.id),
                  child: ListView(children: [
                    Column(
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
                  ]),
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListTile(
                        title: notEmpty
                            ? Text(LocaleKeys.totalPrice
                                .tr(args: [state.getTotalPrice().toString()]))
                            : Text(LocaleKeys.chooseSomeSeatsAbove.tr()),
                        trailing: ElevatedButton(
                          onPressed: (notEmpty)
                              ? () async {
                                  BlocProvider.of<SeatsCubit>(context)
                                      .bookSeats(session.id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                              value: TransactionCubit(
                                                  locator<SessionsRepository>(),
                                                  session.id,
                                                  state.seats.keys),
                                              child: TransactionScreen(
                                                  totalPrice:
                                                      state.getTotalPrice()))));
                                }
                              : null,
                          child: Text(LocaleKeys.submit.tr()),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(LocaleKeys.pickedSeats.tr(),
                        style: const TextStyle(fontSize: 16)),
                    Expanded(
                        child: ListView.separated(
                      itemCount: seats.length,
                      itemBuilder: (context, index) =>
                          Text(LocaleKeys.rowSeat.tr(args: [
                        seats.elementAt(index).rowIndex.toString(),
                        seats.elementAt(index).index.toString()
                      ])),
                      separatorBuilder: (_, __) => const SizedBox(height: 5),
                    ))
                  ]),
                ));
          },
        ));
  }
}
