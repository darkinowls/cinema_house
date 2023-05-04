import 'package:cinema_house/core/dio_client.dart';
import 'package:cinema_house/features/lang/data/lang_interceptor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../cubit/lang_cubit.dart';

class LangRepository {
  final DioClient _dioClient;
  final BuildContext _context;

  LangRepository(this._dioClient, this._context) {
    _dioClient.dio.interceptors.add(LangInterceptor(this));
  }

  LangStatus getLangStatus() {
    return LangStatus.getLang(_context.locale.languageCode);
  }

  LangStatus switchLang() {
    final LangStatus langStatus =
        LangStatus.switchLang(_context.locale.languageCode);
    _context.setLocale(Locale(langStatus.lang));
    return langStatus;
  }
}
