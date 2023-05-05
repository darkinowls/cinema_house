// import 'package:cinema_house/features/lang/cubit/lang_cubit.dart';
// import 'package:dio/dio.dart';
//
// import '../cubit/lang_state.dart';
// import '../repositories/lang_repository.dart';
//
// class LangInterceptor extends Interceptor {
//   LangInterceptor(this._langRepository);
//
//   final LangRepository _langRepository;
//
//   @override
//   Future onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     final LangStatus langStatus = _langRepository.getLangStatus();
//     if (options.headers.containsKey('Accept-Language')) {
//       options.headers['Accept-Language'] = langStatus.lang;
//     } else {
//       options.headers.putIfAbsent('Accept-Language', () => langStatus.lang);
//     }
//
//     return super.onRequest(options, handler);
//   }
// }
