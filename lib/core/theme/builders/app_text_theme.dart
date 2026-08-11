import 'package:flutter/material.dart';
import '../tokens/app_typography.dart';

class AppTextThemeBuilder {
  AppTextThemeBuilder._();

  static TextTheme build(ColorScheme scheme) {
    final base = TextTheme(
      headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    );

    return base
        .apply(
          fontFamily: AppTypography.fontFamily,
          bodyColor: scheme.onSurface,
          displayColor: scheme.onSurface,
        );
  }
}
