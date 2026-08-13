import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import '../errors/error_translator.dart';
import '../../core/localization/translate_extension.dart';
import '../theme/app_theme.dart';

class AppToast {
  static void success(BuildContext context, String message) {
    _show(
      context: context,
      message: message,
      type: ToastificationType.success,
      color: context.colors.success,
      icon: Icons.check_rounded,
    );
  }

  static void error(BuildContext context, String message) {
    final translated = ErrorTranslator.translate(context, message);
    _show(
      context: context,
      message: context.tr(translated),
      type: ToastificationType.error,
      color: context.colorScheme.error,
      icon: Icons.error_outline_rounded,
    );
  }

  static void warning(BuildContext context, String message) {
    _show(
      context: context,
      message: message,
      type: ToastificationType.warning,
      color: context.colors.warning,
      icon: Icons.warning_amber_rounded,
    );
  }

  static void info(BuildContext context, String message) {
    _show(
      context: context,
      message: message,
      type: ToastificationType.info,
      color: context.colorScheme.primary,
      icon: Icons.info_rounded,
    );
  }

  static void _show({
    required BuildContext context,
    required String message,
    required ToastificationType type,
    required Color color,
    required IconData icon,
    Alignment align = Alignment.topCenter,
  }) {
    final scheme = context.colorScheme;
    final shadows = context.shadows;

    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      alignment: align,
      autoCloseDuration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 350),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderRadius: AppRadius.smallAll,
      boxShadow: shadows.sm,
      backgroundColor: scheme.surface,
      borderSide: BorderSide(color: color.withValues(alpha: .05)),
      icon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Icon(icon, color: context.colors.white, size: 16),
      ),
      description: Text(
        message,
        style: TextStyle(
          color: scheme.onSurface,
          fontWeight: FontWeight.w600,
          fontSize: 11.5,
        ),
      ),
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      progressBarTheme: ProgressIndicatorThemeData(
        color: color,
        linearMinHeight: 1.5,

        linearTrackColor: color.withValues(alpha: .15),
      ),
      showProgressBar: true,
    );
  }
}
