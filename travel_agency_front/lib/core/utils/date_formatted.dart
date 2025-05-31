import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime date) {
    return DateFormat('d MMMM, yyyy', 'es_ES').format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a', 'es_ES').format(date);
  }

  static String formatFull(DateTime date) {
    return '${formatDate(date)} - ${formatTime(date)}';
  }
}
