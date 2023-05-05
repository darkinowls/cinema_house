// part of 'lang_cubit.dart';
//
import 'dart:ui';

enum LangStatus {
  uk("uk"),
  en("en");

  final String lang;

  const LangStatus(this.lang);

  static LangStatus getLang(Locale locale) {
    if (LangStatus.en.lang == locale.languageCode) {
      return LangStatus.en;
    }
    return LangStatus.uk;
  }

  static LangStatus switchLang(Locale locale){
    if (LangStatus.en.lang == locale.languageCode) {
      return LangStatus.uk;
    }
    return LangStatus.en;
  }

}
//
// class LangState extends Equatable {
//   final LangStatus status;
//
//   const LangState(this.status);
//
//   @override
//   List<Object> get props => [status];
// }
