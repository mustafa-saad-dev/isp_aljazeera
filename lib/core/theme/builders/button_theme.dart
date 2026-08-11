import 'package:flutter/material.dart';
import '../tokens/app_radius.dart';

class AppButtonThemeBuilder {
  AppButtonThemeBuilder._();

  static ElevatedButtonThemeData elevated(ColorScheme scheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mediumAll),
        elevation: 0,
      ),
    );
  }

  static OutlinedButtonThemeData outlined(ColorScheme scheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: scheme.primary,
        side: BorderSide(color: scheme.primary),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mediumAll),
      ),
    );
  }

  static TextButtonThemeData text(ColorScheme scheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: scheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.smallAll),
      ),
    );
  }
}
