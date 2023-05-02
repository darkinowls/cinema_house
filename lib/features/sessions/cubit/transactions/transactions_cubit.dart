import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/card_form.dart';
import '../../domain/entities/seat_with_row.dart';
import '../../domain/repositories/sessions_repository.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final SessionsRepository _sessionsRepository;

  TransactionsCubit(this._sessionsRepository, int sessionId,
      Iterable<int> seatIds)
      : super(TransactionsState(
      sessionId: sessionId, seatIds: seatIds));

  // void buSeats (){
  //   _sessionsRepository.bookSeats(state.seats, state.sessionId);
  // }

}
