import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'theme_state.dart';

class ThemeController extends Cubit<AppThemeState> {
  static const _storage = FlutterSecureStorage();
  static const _key = 'APP_THEME_MODE';

  ThemeController() : super(const AppThemeState(ThemeMode.system, "system"));

  Future<void> loadSavedTheme() async {
    final saved = await _storage.read(key: _key);

    switch (saved) {
      case 'dark':
        emit(const AppThemeState(ThemeMode.dark, 'dark'));
        break;

      case 'light':
        emit(const AppThemeState(ThemeMode.light, 'light'));
        break;

      case 'system':
      default:
        emit(const AppThemeState(ThemeMode.system, 'system'));
        break;
    }
  }

  Future toggleTheme(ThemeMode theme) async {
    String mode;

    switch (theme) {
      case ThemeMode.light:
        mode = 'light';
        break;

      case ThemeMode.dark:
        mode = 'dark';
        break;

      case ThemeMode.system:
        mode = 'system';
        break;
    }

    await _storage.write(key: _key, value: mode);

    emit(AppThemeState(theme, mode));
  }
}
