// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "logIn": "Log in",
  "enterYourPhoneNumberToLoginViaSms": "Enter your phone number to login via SMS",
  "enterYourPhone": "Enter your phone",
  "numbersAreRequired": "Numbers are required",
  "enterThePinYouHaveGottenViaSms": "Enter the pin you have gotten via SMS",
  "attempts": "Attempts: {}",
  "resendPin": "Resend pin",
  "ifYouDidntReceiveOne": " if you didn't receive one",
  "wrongPhoneNumber": "Wrong phone number? ",
  "goBack": "Go back",
  "loading": "Loading...",
  "movies": "Movies",
  "myTickets": "My tickets",
  "settings": "Settings",
  "noTickets": "No tickets",
  "youCanBuyThemInTheMoviesTab": "You can buy them in the Movies tab",
  "notificationsAndSounds": "Notifications and sounds",
  "privacyAndSecurity": "Privacy and security",
  "switchLanguage": "Switch language",
  "logout": "Logout",
  "byDays": "By days",
  "topCharts": "Top charts"
};
static const Map<String,dynamic> uk = {
  "logIn": "Увійти",
  "enterYourPhoneNumberToLoginViaSms": "Введіть свій номер телефону, аби увійти через СМС",
  "enterYourPhone": "Введіть ваш номер",
  "numbersAreRequired": "Потребуються цифри",
  "enterThePinYouHaveGottenViaSms": "Введіть пін-код отриманий через СМС",
  "attempts": "Спроби: {}",
  "resendPin": "Переслати пін",
  "ifYouDidntReceiveOne": " якщо не був отриманим",
  "wrongPhoneNumber": "Неправильний номер телефону? ",
  "goBack": "Повернутися",
  "loading": "Завантаження...",
  "movies": "Кіно",
  "myTickets": "Мої білети",
  "settings": "Налаштування",
  "noTickets": "Немає білетів",
  "youCanBuyThemInTheMoviesTab": "Ви можите купити їх у вкладці Кіно",
  "notificationsAndSounds": "Повідомлення та звуки",
  "privacyAndSecurity": "Приватність та безпека",
  "switchLanguage": "Змінити мову",
  "logout": "Вийти з аккаунта",
  "byDays": "За днями",
  "topCharts": "Популярне"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "uk": uk};
}
