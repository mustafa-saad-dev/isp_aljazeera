import 'package:flutter/material.dart';
import '../tokens/app_radius.dart';

class AppInputThemeBuilder {
  AppInputThemeBuilder._();

  static InputDecorationTheme build(ColorScheme scheme) {
    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: AppRadius.mediumAll,
      borderSide: BorderSide(color: color),
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: scheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: border(scheme.outline),
      enabledBorder: border(scheme.outline),
      focusedBorder: border(scheme.primary),
      errorBorder: border(scheme.error),
      focusedErrorBorder: border(scheme.error),
    );
  }
}
