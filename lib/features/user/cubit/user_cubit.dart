// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
//
// import '../domain/entities/user_entity.dart';
// import '../domain/user_repository.dart';
//
// part 'user_state.dart';
//
// class UserCubit extends Cubit<UserState> {
//   final UserRepository _userRepository;
//
//   UserCubit(this._userRepository) : super(const UserState()) {
//     _getCurrentUserId();
//   }
//
//   _getCurrentUserId() async {
//     final UserEntity userEntity = await _userRepository.getCurrentUser();
//     emit(UserState(userName: userEntity.name));
//   }
// }
