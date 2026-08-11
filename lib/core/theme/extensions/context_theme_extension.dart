import 'package:flutter/material.dart';
import '../tokens/app_colors.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_shadows.dart';

extension ContextThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get typography => Theme.of(this).textTheme;

  AppColors get colors => Theme.of(this).extension<AppColors>()!;

  // Spacing/shadows aren't ThemeExtensions (no per-color-scheme variation),
  // so they're exposed directly rather than pulled off Theme.of(this).
  AppSpacing get spacing => AppSpacing.standard;
  AppShadows get shadows =>
      Theme.of(this).brightness == Brightness.dark ? AppShadows.dark : AppShadows.light;
}
