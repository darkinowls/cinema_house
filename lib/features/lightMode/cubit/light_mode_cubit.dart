import 'package:bloc/bloc.dart';

import '../repository/light_mode_repository.dart';

class LightModeCubit extends Cubit<bool> {
  late final LightModeRepository _lightModeRepository;

  LightModeCubit(this._lightModeRepository) : super(false) {
    _initMode();
  }

  void toggleDarkMode(bool value) {
    _lightModeRepository.saveDarkMode(value);
    emit(value);
  }

  void _initMode() async {
    emit(await _lightModeRepository.getDarkMode());
  }
}
