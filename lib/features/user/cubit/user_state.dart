part of 'user_cubit.dart';

@immutable
class UserState extends Equatable {
  final String userName;

  const UserState({
    this.userName = "",
  });

  @override
  List<Object> get props => [userName];
}
