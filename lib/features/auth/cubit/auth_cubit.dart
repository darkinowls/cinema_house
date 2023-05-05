import 'package:bloc/bloc.dart';
import 'package:cinema_house/core/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const PhoneNumberRequired()){
    _tryAutoLogin();
  }

  void sendPinOnPhoneNumber(String phoneNumber) async {
    emit(Loading(state));
    bool success = await _authRepository.sendPhone(phoneNumber);
    if (success) {
      emit(OTPRequired(phoneNumber: phoneNumber));
      return;
    }
    emit(PhoneNumberError(errorMessage: LocaleKeys.incorrectPhoneNumber.tr() ));
  }

  void login(String otp) async {
    emit(Loading(state));
    try {
      await _authRepository.login(otp, state.phoneNumber);
      emit(AuthSuccess());
    } on DioError catch (e) {
      if (state.pinAttempts == 1) {
        returnToPhonePrompt(
            LocaleKeys.incorrect3PinsWereWritten.tr()
            );
        return;
      }
      emit(OTPError(
          phoneNumber: state.phoneNumber,
          pinAttempts: state.pinAttempts - 1));
    }
  }

  void _tryAutoLogin() async {
    String? accessToken = await _authRepository.getToken();
    if (accessToken == null) return;
    emit(AuthSuccess());
  }

  void returnToPhonePrompt([String errorMessage = ""]) {
    emit(PhoneNumberRequired(errorMessage: errorMessage));
  }

  void logout() {
    _authRepository.deleteToken();
    returnToPhonePrompt();
  }
}
