import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'theme_state.dart';

class ThemeController extends Cubit<ThemeState> {
  static const _storageKey = 'theme_mode';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ThemeController() : super(const ThemeInitial());

  Future<void> loadSavedTheme() async {
    final saved = await _storage.read(key: _storageKey);
    emit(ThemeLoaded(_decode(saved)));
  }

  Future<void> setTheme(ThemeMode mode) async {
    emit(ThemeLoaded(mode));
    await _storage.write(key: _storageKey, value: mode.name);
  }

  ThemeMode _decode(String? value) {
    return ThemeMode.values.firstWhere(
      (m) => m.name == value,
      orElse: () => ThemeMode.system,
    );
  }
}
