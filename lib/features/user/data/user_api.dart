import 'package:dio/dio.dart';

import '../../../core/dio_client.dart';
import 'models/user_model.dart';

class UserApi {
  final DioClient _dioClient;
  final String _url = '/user';

  UserApi(this._dioClient);

  Future<UserModel> getCurrentUser() async {
    final Response response =
        await _dioClient.dio.get(_url);
    return UserModel.fromJson(response.data['data']);
  }
}
