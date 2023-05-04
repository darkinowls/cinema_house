import 'dart:ui';

import 'package:cinema_house/core/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

extension DataFormatExtention on DateTime {
  String formatDate(Locale locale) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final aDate = DateTime(year, month, day);
    if (aDate == today) {
      return LocaleKeys.today.tr(args: [
        DateFormat('yyyy MMMM(MM) dd', locale.languageCode).format(this)
      ]);
    }
    if (aDate == tomorrow) {
      return LocaleKeys.tomorrow.tr(args: [
        DateFormat('yyyy MMMM(MM) dd', locale.languageCode).format(this)
      ]);
    }
    return DateFormat('EEEE, yyyy MMMM(MM) dd', locale.languageCode)
        .format(this);
  }

  String formatTime() {
    return DateFormat('HH:mm').format(this);
  }
}
