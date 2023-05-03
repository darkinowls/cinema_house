import 'package:bloc/bloc.dart';
import 'package:cinema_house/features/sessions/cubit/sessions/sessions_cubit.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/seat_with_row.dart';
import '../../domain/repositories/sessions_repository.dart';

part 'seats_state.dart';

class SeatsCubit extends Cubit<SeatsState> {
  final SessionsCubit _sessionsCubit;
  final SessionsRepository _sessionsRepository;

  SeatsCubit(this._sessionsCubit, this._sessionsRepository) : super(const SeatsState());

  void toggleSeat(SeatEntity seat) {
    Map<int, SeatEntity> seats = {...state.seats};
    SeatEntity? removed = seats.remove(seat.id);
    if (removed == null) {
      seats[seat.id] = seat;
    }
    emit(state.copyWith(seats: seats));
  }

  Future<Iterable<int>> bookSeats(int sessionId) async {
    emit(state.copyWith(status: SeatsStatus.loading));
    Iterable<int> seatIds = state.seats.keys;
    bool booked = await _sessionsRepository.bookSeats(
      seatIds,
      sessionId,
    );
    print(seatIds);
    if (booked) {
      await _sessionsCubit.updateSessionRoom(sessionId);
      emit(const SeatsState(status: SeatsStatus.success));
      return seatIds;
    }
    emit(const SeatsState(status: SeatsStatus.failed));
    return [];
  }

  void updateSession(int sessionId) async {
    emit(const SeatsState(status: SeatsStatus.loading));
    await _sessionsCubit.updateSessionRoom(sessionId);
    emit(const SeatsState());
  }

}
