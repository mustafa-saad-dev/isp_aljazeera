import 'package:flutter/material.dart';

class AppSelectionControlsThemeBuilder {
  AppSelectionControlsThemeBuilder._();

  static CheckboxThemeData checkbox(ColorScheme scheme) {
    return CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected) ? scheme.primary : Colors.transparent,
      ),
      side: BorderSide(color: scheme.outline),
    );
  }

  static RadioThemeData radio(ColorScheme scheme) {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected) ? scheme.primary : scheme.outline,
      ),
    );
  }

  static SwitchThemeData switchTheme(ColorScheme scheme) {
    return SwitchThemeData(
      thumbColor: const WidgetStatePropertyAll(Colors.white),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected) ? scheme.primary : scheme.outlineVariant,
      ),
    );
  }
}
