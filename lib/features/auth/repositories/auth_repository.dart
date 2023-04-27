import 'package:cinema_house/features/auth/data/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../data/models/phone_number.dart';
import '../data/models/otp.dart';
import '../data/models/token.dart';
import '../data/auth_api.dart';

class AuthRepository {
  final Box<String> _tokenBox;
  final String _key = 'accessToken';

  final UserApi _userApi;

  AuthRepository(this._tokenBox, this._userApi) {
    _userApi.addInterceptor(TokenInterceptor(this));
  }

  Future<String?> getToken() async {
    return _tokenBox.get(_key);
  }

  void deleteToken() {
    _tokenBox.delete(_key);
  }

  String _saveToken(String token) {
    _tokenBox.put(_key, token);
    return token;
  }

  Future<bool> sendPhone(String phoneNumber) async {
    bool success =
        await _userApi.sendPhone(PhoneNumber(phoneNumber: phoneNumber));
    return success;
  }

  Future<Token> login(String otp, String phoneNumber) async {
    Token token = await _userApi.login(
        OTP(otp: otp), PhoneNumber(phoneNumber: phoneNumber));
    _saveToken(token.accessToken);
    return token;
  }
}
