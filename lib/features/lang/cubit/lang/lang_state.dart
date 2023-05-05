part of 'lang_cubit.dart';


enum LangStatus {
  uk("uk"),
  en("en");

  final String text;

  const LangStatus(this.text);

  static LangStatus getLang(Locale locale) {
    if (LangStatus.en.text == locale.languageCode) {
      return LangStatus.en;
    }
    return LangStatus.uk;
  }

  static LangStatus switchLang(Locale locale){
    if (LangStatus.en.text == locale.languageCode) {
      return LangStatus.uk;
    }
    return LangStatus.en;
  }

}

class LangState extends Equatable {
  final LangStatus status;

  const LangState(this.status);

  @override
  List<Object> get props => [status];
}
