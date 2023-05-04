import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio();
  final String _url = "https://fs-mt.qwerty123.tech/api";

  DioClient() {
    dio.options = BaseOptions(
      baseUrl: _url,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 8),
      // headers: {'Accept-Language': context.locale.languageCode},
    );
  }
}