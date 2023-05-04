import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/status.dart';
import '../../data/models/session.dart';
import '../../domain/entities/seat_with_row.dart';
import '../../domain/repositories/sessions_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final SessionsRepository _sessionsRepository;

  SessionCubit(Session session, this._sessionsRepository)
      : super(SessionState(session: session));

  void toggleSeat(SeatEntity seat) {
    Map<int, SeatEntity> seats = {...state.seats};
    SeatEntity? removed = seats.remove(seat.id);
    if (removed == null) {
      seats[seat.id] = seat;
    }
    emit(state.copyWith(seats: seats));
  }

  Future<Iterable<int>> bookSeats(int sessionId) async {
    emit(state.copyWith(status: Status.loading));
    Iterable<int> seatIds = state.seats.keys;
    bool booked = await _sessionsRepository.bookSeats(
      seatIds,
      sessionId,
    );
    if (booked) {
      emit(state.copyWith(status: Status.success, seats: {}));
      return seatIds;
    }
    emit(state.copyWith(status: Status.failed, seats: {}));
    return [];
  }

  void updateSession(int sessionId) async {
    emit(state.copyWith(status: Status.loading, seats: {}));
    Session session = await _sessionsRepository.getSessionById(sessionId);
    emit(state.copyWith(session: session, status: Status.loaded));
  }
}
