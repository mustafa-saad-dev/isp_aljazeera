import 'package:flutter/material.dart';
import '../tokens/app_radius.dart';

class AppMenuThemeBuilder {
  AppMenuThemeBuilder._();

  static PopupMenuThemeData popup(ColorScheme scheme) {
    return PopupMenuThemeData(
      color: scheme.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.mediumAll),
      elevation: 4,
    );
  }

  static DropdownMenuThemeData dropdown(ColorScheme scheme) {
    return DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(scheme.surface),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: AppRadius.mediumAll),
        ),
      ),
    );
  }
}
