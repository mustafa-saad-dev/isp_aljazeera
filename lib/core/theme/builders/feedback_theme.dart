import 'package:flutter/material.dart';
import '../tokens/app_radius.dart';

class AppFeedbackThemeBuilder {
  AppFeedbackThemeBuilder._();

  static SnackBarThemeData snackBar(ColorScheme scheme) {
    return SnackBarThemeData(
      backgroundColor: scheme.inverseSurface,
      contentTextStyle: TextStyle(color: scheme.onInverseSurface),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.smallAll),
      behavior: SnackBarBehavior.floating,
    );
  }

  static TooltipThemeData tooltip(ColorScheme scheme) {
    return TooltipThemeData(
      decoration: BoxDecoration(
        color: scheme.inverseSurface,
        borderRadius: AppRadius.smallAll,
      ),
      textStyle: TextStyle(color: scheme.onInverseSurface, fontSize: 12),
    );
  }
}
