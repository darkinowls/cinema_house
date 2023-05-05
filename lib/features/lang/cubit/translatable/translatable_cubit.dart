import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../lang/lang_cubit.dart';

part 'translatable_state.dart';

abstract class TranslatableCubit<State> extends Cubit<State> {
  final LangCubit langCubit;
  late final StreamSubscription<LangState> _subscription;

  TranslatableCubit({required State initialState, required this.langCubit})
      : super(initialState);

  void subscribeLangCubitChanges(Function callback){
    _subscription = langCubit.stream.listen((event) async => callback);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

}
