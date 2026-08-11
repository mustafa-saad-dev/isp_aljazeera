import 'package:flutter/material.dart';

import 'tokens/app_color_scheme.dart';
import 'tokens/app_colors.dart';
import 'tokens/app_radius.dart';
import 'tokens/app_shadows.dart';
import 'tokens/app_spacing.dart';
import 'tokens/app_typography.dart';
import 'theme_builder.dart';

export 'tokens/app_colors.dart' show AppColors;
export 'tokens/app_radius.dart' show AppRadius;
export 'tokens/app_shadows.dart' show AppShadows;
export 'tokens/app_spacing.dart' show AppSpacing;
export 'tokens/app_typography.dart' show AppTypography;
export 'extensions/context_theme_extension.dart' show ContextThemeExtension;

class AppTheme {
  AppTheme._();

  static ThemeData get light => AppThemeBuilder.build(
    scheme: AppColorScheme.light,
    colors: AppColors.light,
    spacing: AppSpacing.standard,
    shadows: AppShadows.light,
  );

  static ThemeData get dark => AppThemeBuilder.build(
    scheme: AppColorScheme.dark,
    colors: AppColors.dark,
    spacing: AppSpacing.standard,
    shadows: AppShadows.dark,
  );

  static const String fontFamily = AppTypography.fontFamily;

  static const Radius rSmall = AppRadius.small;
  static const Radius rMedium = AppRadius.medium;
  static const Radius rLarge = AppRadius.large;
  static const BorderRadius smallRadius = AppRadius.smallAll;
  static const BorderRadius mediumRadius = AppRadius.mediumAll;
  static const BorderRadius largeRadius = AppRadius.largeAll;
}
