import 'package:cinema_house/core/locale_keys.g.dart';
import 'package:cinema_house/features/lightMode/cubit/light_mode_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LightModeSwitch extends StatelessWidget {
  const LightModeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightModeCubit, bool>(
        builder: (context, state) => SwitchListTile(
            title: Text(LocaleKeys.lightMode.tr()), // Builds the tile
            value: state,
            onChanged:
                BlocProvider.of<LightModeCubit>(context).toggleDarkMode));
  }
}
