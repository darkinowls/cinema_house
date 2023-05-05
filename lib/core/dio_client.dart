import 'dart:ui';

import 'package:dio/dio.dart';

import '../features/lang/cubit/lang_state.dart';

class DioClient {
  final Dio dio = Dio();
  final String _url = "https://fs-mt.qwerty123.tech/api";

  DioClient() {
    dio.options = BaseOptions(
      baseUrl: _url,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 8),
    );
  }

  void setLanguage(Locale locale){
    final LangStatus langStatus = LangStatus.getLang(locale);
    dio.options.headers = {
      "Accept-Language": langStatus.lang
    };
  }


}