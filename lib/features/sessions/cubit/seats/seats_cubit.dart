import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/seat_with_row.dart';

part 'seats_state.dart';

class SeatsCubit extends Cubit<SeatsState> {
  SeatsCubit() : super(const SeatsState());

  toggleSeat(SeatEntity seat) {
    Map<int, SeatEntity> seats = {...state.seats};
    SeatEntity? removed = seats.remove(seat.id);
    if (removed == null) {
      seats[seat.id] = seat;
    }
    emit(state.copyWith(seats: seats));
  }
}
