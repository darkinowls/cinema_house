import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repositories/lang_repository.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  final LangRepository _langRepository;

  LangCubit(this._langRepository)
      : super(LangState(_langRepository.getLangStatus()));

  void switchLang() {
    final LangStatus langStatus = _langRepository.switchLang();
    emit(LangState(langStatus));
  }
}
