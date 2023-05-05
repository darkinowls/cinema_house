part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {
  final int pinAttempts;
  final String errorMessage;
  final String phoneNumber;

  const AuthState(
      {this.pinAttempts = 3, this.errorMessage = "", this.phoneNumber = ""});

  @override
  List<Object> get props => [pinAttempts, errorMessage, phoneNumber];
}

class PhoneNumberRequired extends AuthState {
  const PhoneNumberRequired({super.errorMessage});
}

class PhoneNumberError extends AuthState {
  const PhoneNumberError({required super.errorMessage});
}

class Loading extends AuthState {
  Loading(AuthState state)
      : super(
            phoneNumber: state.phoneNumber,
            pinAttempts: state.pinAttempts,
            errorMessage: state.errorMessage);
}

class OTPRequired extends AuthState {
  const OTPRequired({required super.phoneNumber});
}

class OTPError extends AuthState {
  const OTPError(
      {required super.phoneNumber,
      required super.pinAttempts});
}

class AuthSuccess extends AuthState {}
