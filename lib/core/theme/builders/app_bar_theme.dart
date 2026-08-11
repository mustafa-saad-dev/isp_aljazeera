import 'package:flutter/material.dart';

class AppBarThemeBuilder {
  AppBarThemeBuilder._();

  static AppBarTheme build(ColorScheme scheme) {
    return AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ),
    );
  }
}
