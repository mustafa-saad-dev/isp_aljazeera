import 'package:flutter/material.dart';
import '../tokens/app_radius.dart';

class AppChipAndFabThemeBuilder {
  AppChipAndFabThemeBuilder._();

  static ChipThemeData chip(ColorScheme scheme) {
    return ChipThemeData(
      backgroundColor: scheme.surfaceContainerHighest,
      selectedColor: scheme.primary.withValues(alpha: 0.14),
      labelStyle: TextStyle(color: scheme.onSurface, fontSize: 13),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.smallAll),
      side: BorderSide.none,
    );
  }

  static FloatingActionButtonThemeData fab(ColorScheme scheme) {
    return FloatingActionButtonThemeData(
      backgroundColor: scheme.primary,
      foregroundColor: scheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.largeAll),
    );
  }
}
