import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';

class AppTranslations {
  AppTranslations._();

  static const String _langFolder = 'assets/lang/';
  static bool _loaded = false;
  static final Map<String, Map<String, String>> _values = {};

  static Locale locale = const Locale('ar');
  static final List<Locale> supportedLocales = const [
    Locale('ar'),
    Locale('en'),
    Locale('ku'),
  ];

  static Future<void> load() async {
    if (_loaded) return;

    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final langFiles = manifest.listAssets().where(
      (path) => path.startsWith(_langFolder) && path.endsWith('.json'),
    );

    for (final path in langFiles) {
      final code = path.split('/').last.replaceAll('.json', '');
      final raw = await rootBundle.loadString(path);
      final Map<String, dynamic> decoded = json.decode(raw);
      _values[code] = decoded.map(
        (key, value) => MapEntry(key, value.toString()),
      );
    }

    _loaded = true;
  }

  static String tr(String key) {
    return _values[locale.languageCode]?[key] ?? key;
  }
}
