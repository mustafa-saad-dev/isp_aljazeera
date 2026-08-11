import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class AppTranslations {
  AppTranslations._();

  static const supportedLocales = ['ar', 'en', 'ku'];
  static const fallbackLocale = 'ar';

  static final Map<String, Map<String, String>> _translations = {};

  static Future<void> load() async {
    for (final locale in supportedLocales) {
      final raw = await rootBundle.loadString('assets/lang/$locale.json');
      final Map<String, dynamic> decoded = jsonDecode(raw);
      _translations[locale] = decoded.map(
        (key, value) => MapEntry(key, value.toString()),
      );
    }
  }

  static String translate(String languageCode, String key) {
    final table = _translations[languageCode] ?? _translations[fallbackLocale];
    return table?[key] ?? key;
  }
}
