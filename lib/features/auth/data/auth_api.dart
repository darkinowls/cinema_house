import 'package:cinema_house/features/auth/data/models/phone_number.dart';
import 'package:cinema_house/features/auth/data/models/token.dart';
import 'package:dio/dio.dart';

import '../../../core/dio_client.dart';
import 'models/otp.dart';
import 'token_interceptor.dart';

class UserApi {
  final DioClient _dioClient;
  final String _authUrl = '/auth';

  UserApi(this._dioClient);

  Future<bool> sendPhone(PhoneNumber phoneNumber) async {
    FormData formData = FormData.fromMap(phoneNumber.toJson()); // to Json
    final Response response =
        await _dioClient.dio.post("$_authUrl/otp", data: formData);
    return response.data["success"];
  }

  Future<Token> login(OTP pin, PhoneNumber phoneNumber) async {

    Map<String, dynamic> a = {
      ...pin.toJson(),
      ...phoneNumber.toJson(),
    };

    FormData formData = FormData.fromMap(a); // to Json
    final Response response =
        await _dioClient.dio.post("$_authUrl/login", data: formData);
    return Token.fromJson(response.data['data']);
  }

  void addInterceptor(TokenInterceptor tokenInterceptor) {
    _dioClient.dio.interceptors.add(tokenInterceptor);
  }
}
