import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/status.dart';
import '../../lang/cubit/lang/lang_cubit.dart';
import '../../lang/cubit/translatable/translatable_cubit.dart';
import '../../network/cubit/network_cubit.dart';
import '../domain/entities/ticket_entity.dart';
import '../domain/repositories/tickets_repository.dart';

part 'tickets_state.dart';

class TicketsCubit extends TranslatableCubit<TicketsState> {
  final TicketsRepository _ticketsRepository;
  final NetworkCubit _networkCubit;
  late StreamSubscription<NetworkState> _networkSubscription;

  TicketsCubit(this._ticketsRepository, this._networkCubit, LangCubit langCubit )
      : super(initialState: const TicketsState(), langCubit:langCubit) {
    getTickets();
    langSubscription = langCubit.stream.listen((_) => getTickets());
    _networkSubscription = _networkCubit.stream.listen((_) => getTickets());
  }

  Future<void> getTickets() async {
    Iterable<TicketEntity> tickets = await _ticketsRepository.getTickets(
      _networkCubit.state is NetworkExists,
    );
    emit(state.copyWith(status: Status.loaded, tickets: [...tickets]));
  }

  @override
  Future<void> close() {
    _networkSubscription.cancel();
    return super.close();
  }
}
