import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../lang/lang_cubit.dart';

part 'translatable_state.dart';

abstract class TranslatableCubit<State> extends Cubit<State> {
  final LangCubit langCubit;
  StreamSubscription<LangState>? langSubscription;

  TranslatableCubit({required State initialState, required this.langCubit})
      : super(initialState);


  @override
  Future<void> close() {
    langSubscription?.cancel();
    return super.close();
  }

}
