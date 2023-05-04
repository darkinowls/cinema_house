import 'package:easy_localization/easy_localization.dart';

import '../../../../../core/locale_keys.g.dart';

class TransactionUtils {
  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static String? validateEmail(String? input) {
    if (input == null || input.isEmpty) {
      return LocaleKeys.thisFieldIsRequired.tr();
    }
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input);
    if (!emailValid) {
      return LocaleKeys.thatsIncorrectEmail.tr();
    }
    return null;
  }

  static String? validateCardNumber(String? input) {
    if (input == null || input.isEmpty) {
      return LocaleKeys.thisFieldIsRequired.tr();
    }
    input = getCleanedNumber(input);
    if (input.length < 16) {
      return LocaleKeys.incorrectCardNumber.tr();
    }
    return null;
  }

  static String? validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.thisFieldIsRequired.tr();
    }
    if (value.length != 3) {
      return LocaleKeys.incorrectCvvLength.tr();
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.thisFieldIsRequired.tr();
    }
    int year;
    int month;
    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split(RegExp(r'(/)'));

      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }
    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return LocaleKeys.expiryMonthIsInvalid.tr();
    }
    var fourDigitsYear = _convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return LocaleKeys.expiryYearIsInvalid.tr();
    }
    if (!_hasDateExpired(month, year)) {
      return LocaleKeys.cardHasExpired.tr();
    }
    return null;
  }

  static int _convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool _hasDateExpired(int month, int year) {
    return _isNotExpired(year, month);
  }

  static bool _isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !_hasYearPassed(year) && !_hasMonthPassed(year, month);
  }

  static List<int> _getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool _hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return _hasYearPassed(year) ||
        _convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool _hasYearPassed(int year) {
    int fourDigitsYear = _convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }
}
