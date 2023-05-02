import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/seats/seats_cubit.dart';
import '../../data/models/seat.dart';
import '../../domain/entities/seat_with_row.dart';

final Map<int, Map<bool, Color>> _seatColorMap = {
  0: {
    false: Colors.green.withOpacity(0.5),
    true: Colors.green,
  },
  1: {
    false: Colors.blue.withOpacity(0.5),
    true: Colors.blue,
  },
  2: {
    false: Colors.purple.withOpacity(0.5),
    true: Colors.purple,
  },
};

class SeatCheckBox extends StatefulWidget {
  final SeatEntity seat;

  const SeatCheckBox({Key? key, required this.seat}) : super(key: key);

  @override
  State<SeatCheckBox> createState() => _SeatCheckBoxState();
}

class _SeatCheckBoxState extends State<SeatCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (widget.seat.isAvailable) ? 35 : 25,
      width: (widget.seat.isAvailable) ? 25 : 15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: _seatColorMap[widget.seat.type]![widget.seat.isAvailable]),
      child: Checkbox(
          fillColor: MaterialStateProperty.all(Colors.transparent),
          splashRadius: 15,
          value: isChecked,
          onChanged:
              (widget.seat.isAvailable)
                  ?
              (bool? value) {
            setState(() => isChecked = !isChecked);
            BlocProvider.of<SeatsCubit>(context).toggleSeat(widget.seat);
          }
          : null
          ),
    );
  }
}
