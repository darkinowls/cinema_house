import 'package:cinema_house/features/network/cubit/network_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/locale_keys.g.dart';
import '../../../../core/locator.dart';
import '../../../../features/tickets/cubit/tickets_cubit.dart';
import '../../../../features/tickets/domain/repositories/tickets_repository.dart';
import '../../../../features/tickets/widgets/ticket_list.dart';

class MyTicketsTab extends StatelessWidget {
  const MyTicketsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TicketsCubit(locator<TicketsRepository>(), locator<NetworkCubit>()),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<TicketsCubit, TicketsState>(
            builder: (__, _) {
              return Text(LocaleKeys.myTickets.tr());
            },
          ),
        ),
        body: const TicketList(),
      ),
    );
  }
}
