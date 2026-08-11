import 'package:flutter/material.dart';
import '../tokens/app_radius.dart';

class AppSurfaceThemeBuilder {
  AppSurfaceThemeBuilder._();

  static CardThemeData card(ColorScheme scheme) {
    return CardThemeData(
      color: scheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.mediumAll,
        side: BorderSide(color: scheme.outlineVariant),
      ),
      margin: EdgeInsets.zero,
    );
  }

  static DialogThemeData dialog(ColorScheme scheme) {
    return DialogThemeData(
      backgroundColor: scheme.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.largeAll),
    );
  }
}
