import 'package:dio/dio.dart';

import '../repositories/auth_repository.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor(this.tokenRepository);

  final AuthRepository tokenRepository;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String? token = await tokenRepository.getToken();
    if (token == null) {
      return super.onRequest(options, handler);
    }
    if (options.headers.containsKey('Authorization')) {
      options.headers['Authorization'] = 'Bearer $token';
    } else {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }

    return super.onRequest(options, handler);
  }
}
