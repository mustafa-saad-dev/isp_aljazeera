import 'package:flutter/material.dart';

// Feeds the adaptive shell: NavigationBar on compact (phone), NavigationRail
// on medium/expanded (tablet, Windows, web) — see FL-002 / RootView.
class AppNavigationThemeBuilder {
  AppNavigationThemeBuilder._();

  static NavigationBarThemeData bar(ColorScheme scheme) {
    return NavigationBarThemeData(
      backgroundColor: scheme.surface,
      indicatorColor: scheme.primary.withValues(alpha: 0.12),
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: scheme.onSurface),
      ),
    );
  }

  static NavigationRailThemeData rail(ColorScheme scheme) {
    return NavigationRailThemeData(
      backgroundColor: scheme.surface,
      selectedIconTheme: IconThemeData(color: scheme.primary),
      unselectedIconTheme: IconThemeData(color: scheme.onSurface.withValues(alpha: 0.6)),
      selectedLabelTextStyle: TextStyle(color: scheme.primary, fontWeight: FontWeight.w600),
      unselectedLabelTextStyle: TextStyle(color: scheme.onSurface.withValues(alpha: 0.6)),
    );
  }
}
