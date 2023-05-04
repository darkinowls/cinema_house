// part of 'lang_cubit.dart';
//
enum LangStatus {
  uk("uk"),
  en("en");

  final String lang;

  const LangStatus(this.lang);

  static LangStatus getLang(String lang) {
    if (LangStatus.en.lang == lang) {
      return LangStatus.en;
    }
    return LangStatus.uk;
  }

  static LangStatus switchLang(String lang){
    if (LangStatus.en.lang == lang) {
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
