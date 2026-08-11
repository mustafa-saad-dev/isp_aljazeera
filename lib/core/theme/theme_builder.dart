import 'package:flutter/material.dart';

import 'tokens/app_colors.dart';
import 'tokens/app_shadows.dart';
import 'tokens/app_spacing.dart';
import 'builders/app_text_theme.dart';
import 'builders/app_bar_theme.dart';
import 'builders/button_theme.dart';
import 'builders/chip_and_fab_theme.dart';
import 'builders/feedback_theme.dart';
import 'builders/input_theme.dart';
import 'builders/menu_theme.dart';
import 'builders/navigation_theme.dart';
import 'builders/selection_controls_theme.dart';
import 'builders/surface_theme.dart';

class AppThemeBuilder {
  AppThemeBuilder._();

  static ThemeData build({
    required ColorScheme scheme,
    required AppColors colors,
    required AppSpacing spacing,
    required AppShadows shadows,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: AppTextThemeBuilder.build(scheme),
      appBarTheme: AppBarThemeBuilder.build(scheme),
      elevatedButtonTheme: AppButtonThemeBuilder.elevated(scheme),
      outlinedButtonTheme: AppButtonThemeBuilder.outlined(scheme),
      textButtonTheme: AppButtonThemeBuilder.text(scheme),
      inputDecorationTheme: AppInputThemeBuilder.build(scheme),
      popupMenuTheme: AppMenuThemeBuilder.popup(scheme),
      dropdownMenuTheme: AppMenuThemeBuilder.dropdown(scheme),
      navigationBarTheme: AppNavigationThemeBuilder.bar(scheme),
      navigationRailTheme: AppNavigationThemeBuilder.rail(scheme),
      checkboxTheme: AppSelectionControlsThemeBuilder.checkbox(scheme),
      radioTheme: AppSelectionControlsThemeBuilder.radio(scheme),
      switchTheme: AppSelectionControlsThemeBuilder.switchTheme(scheme),
      cardTheme: AppSurfaceThemeBuilder.card(scheme),
      dialogTheme: AppSurfaceThemeBuilder.dialog(scheme),
      chipTheme: AppChipAndFabThemeBuilder.chip(scheme),
      floatingActionButtonTheme: AppChipAndFabThemeBuilder.fab(scheme),
      snackBarTheme: AppFeedbackThemeBuilder.snackBar(scheme),
      tooltipTheme: AppFeedbackThemeBuilder.tooltip(scheme),
      extensions: [colors],
    );
  }
}
