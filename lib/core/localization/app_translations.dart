import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';

class AppTranslations {
  AppTranslations._();

  static Locale locale = const Locale('ar');
  static final List<Locale> supportedLocales = const [
    Locale('ar'),
    Locale('en'),
  ];

  static Map<String, String> _strings = {};

  static Future<void> load([Locale? locale]) async {
    final l = locale ?? AppTranslations.locale;
    AppTranslations.locale = l;
    final path = 'assets/lang/${l.languageCode}.json';
    final jsonStr = await rootBundle.loadString(path);
    final map = Map<String, dynamic>.from(json.decode(jsonStr));
    _strings = map.map((k, v) => MapEntry(k, v.toString()));
  }

  static String tr(String key) => _strings[key] ?? key;
}
