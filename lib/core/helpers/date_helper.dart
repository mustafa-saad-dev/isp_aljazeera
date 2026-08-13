import 'package:intl/intl.dart';
import '../../core/localization/app_translations.dart';

class DateHelper {
  DateHelper._();

  static String _locale() => AppTranslations.locale.languageCode;

  static String format(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    try {
      return DateFormat(pattern, _locale()).format(date);
    } catch (_) {
      return DateFormat(pattern).format(date);
    }
  }

  static String formatDate(DateTime date) =>
      format(date, pattern: 'yyyy-MM-dd');

  static String formatDateTime(DateTime date) =>
      format(date, pattern: 'yyyy-MM-dd HH:mm');

  static String formatTime(DateTime date) => format(date, pattern: 'HH:mm');

  static String formatNow({String pattern = 'yyyy-MM-dd HH:mm'}) =>
      format(DateTime.now(), pattern: pattern);

  static String fromIso(String? iso, {String pattern = 'yyyy-MM-dd'}) {
    if (iso == null || iso.isEmpty) return '';
    try {
      return format(DateTime.parse(iso), pattern: pattern);
    } catch (_) {
      return iso;
    }
  }

  static String relative(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inSeconds < 60) return '${diff.inSeconds}s';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return formatDate(date);
  }
}
