import 'package:intl/intl.dart';

extension DataFormatExtention on DateTime {
  String formatDate() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final aDate = DateTime(year, month, day);
    if (aDate == today) {
      return "Today, ${DateFormat('yyyy MMMM(MM) dd').format(this)}";
    }
    if (aDate == tomorrow) {
      return "Tomorrow, ${DateFormat('yyyy MMMM(MM) dd').format(this)}";
    }
    return DateFormat('EEEE, yyyy MMMM(MM) dd').format(this);
  }

  String formatTime() {
    return DateFormat('HH:mm').format(this);
  }
}
