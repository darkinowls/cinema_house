import '../data/user_api.dart';
import 'entities/user_entity.dart';

class UserRepository{
  final UserApi _userApi;

  UserRepository(this._userApi);

  Future<UserEntity> getCurrentUser() async{
    return _userApi.getCurrentUser();
  }
}