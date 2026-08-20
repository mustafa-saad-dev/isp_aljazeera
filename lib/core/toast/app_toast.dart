import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

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
      icon: Icons.check_circle_rounded,
      title: 'تم بنجاح',
    );
  }

  static void error(BuildContext context, String message) {
    print(message);
    final translated = ErrorTranslator.translate(context, message);
    _show(
      context: context,
      message: context.tr(translated),
      type: ToastificationType.error,
      color: context.colorScheme.error,
      icon: Icons.cancel_rounded,
      title: 'خطأ',
    );
  }

  static void warning(BuildContext context, String message) {
    _show(
      context: context,
      message: message,
      type: ToastificationType.warning,
      color: context.colors.warning,
      icon: Icons.warning_rounded,
      title: 'تنبيه',
    );
  }

  static void info(BuildContext context, String message) {
    _show(
      context: context,
      message: message,
      type: ToastificationType.info,
      color: context.colorScheme.primary,
      icon: Icons.info_rounded,
      title: 'معلومة',
    );
  }

  static void _show({
    required BuildContext context,
    required String message,
    required ToastificationType type,
    required Color color,
    required IconData icon,
    required String title,
  }) {
    final scheme = context.colorScheme;
    final shadows = context.shadows;
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      alignment: kIsWeb
          ? Alignment.bottomRight
          : Platform.isAndroid || Platform.isIOS
          ? Alignment.topCenter
          : Alignment.bottomRight,
      autoCloseDuration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 350),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      borderRadius: AppRadius.mediumAll,
      boxShadow: shadows.md,
      backgroundColor: scheme.surface,
      borderSide: BorderSide(
        color: isDark
            ? color.withValues(alpha: 0.25)
            : color.withValues(alpha: 0.12),
        width: 1,
      ),
      sizeConstraints: const BoxConstraints(maxWidth: 360, minHeight: 56),
      icon: Container(
        width: 34,
        height: 34,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.12),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
      description: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          message,
          style: TextStyle(
            color: scheme.onSurface.withValues(alpha: 0.65),
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 1.4,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      closeButton: ToastCloseButton(
        showType: CloseButtonShowType.always,
        buttonBuilder: (context, onClose) {
          return GestureDetector(
            onTap: onClose,
            child: Icon(
              Icons.close_rounded,
              size: 16,
              color: scheme.onSurface.withValues(alpha: 0.3),
            ),
          );
        },
      ),
      showProgressBar: true,
      progressBarTheme: ProgressIndicatorThemeData(
        color: color,
        linearMinHeight: 2,
        linearTrackColor: color.withValues(alpha: 0.08),
      ),
    );
  }
}
