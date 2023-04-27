import 'package:cinema_house/features/lightMode/cubit/light_mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LightModeSwitch extends StatelessWidget {
  const LightModeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightModeCubit, bool>(
        builder: (context, state) => SwitchListTile(
            title: const Text('Light Mode'), // Builds the tile
            value: state,
            onChanged: (value) => BlocProvider.of<LightModeCubit>(context)
                .toggleDarkMode(value)));
  }
}
