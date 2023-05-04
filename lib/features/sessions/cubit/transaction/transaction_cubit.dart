import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/status.dart';
import '../../domain/entities/card_form.dart';
import '../../domain/repositories/sessions_repository.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final SessionsRepository _sessionsRepository;

  TransactionCubit(
      this._sessionsRepository, int sessionId, Iterable<int> seatIds)
      : super(TransactionState(sessionId: sessionId, seatIds: seatIds));

  void buySeats(CardForm cardForm) async {
    emit(state.copyWith(status: Status.loading));

    final bool isBought = await _sessionsRepository.buySeats(
        state.seatIds, state.sessionId, cardForm);

    if (isBought) {
      emit(state.copyWith(status: Status.success));
      return;
    }
    emit(state.copyWith(status: Status.failed));
  }
}
