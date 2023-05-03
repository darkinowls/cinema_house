import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/card_form.dart';
import '../../domain/repositories/sessions_repository.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final SessionsRepository _sessionsRepository;

  TransactionCubit(
      this._sessionsRepository, int sessionId, Iterable<int> seatIds)
      : super(TransactionState(sessionId: sessionId, seatIds: seatIds));

  void buySeats(CardForm cardForm) async {
    emit(state.copyWith(status: TransactionStatus.loading));

    final bool isBought = await _sessionsRepository.buySeats(
        state.seatIds, state.sessionId, cardForm);

    if (isBought) {
      emit(state.copyWith(status: TransactionStatus.success));
    }
    emit(state.copyWith(status: TransactionStatus.failed));
  }
}
