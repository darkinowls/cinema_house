import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/status.dart';
import '../../network/cubit/network_cubit.dart';
import '../domain/entities/ticket_entity.dart';
import '../domain/repositories/tickets_repository.dart';

part 'tickets_state.dart';

class TicketsCubit extends Cubit<TicketsState> {
  final TicketsRepository _ticketsRepository;
  final NetworkCubit _networkCubit;

  TicketsCubit(this._ticketsRepository, this._networkCubit)
      : super(const TicketsState()) {
    getTickets();
    _networkCubit.stream.listen((_) => getTickets());
  }

  Future<void> getTickets() async {
    Iterable<TicketEntity> tickets = await _ticketsRepository.getTickets(
      _networkCubit.state is NetworkExists,
    );
    emit(state.copyWith(status: Status.loaded, tickets: [...tickets]));
  }
}
