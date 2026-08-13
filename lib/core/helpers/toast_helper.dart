import 'package:flutter/material.dart';

class ToastHelper {
  ToastHelper._();

  static void _show(
    BuildContext context,
    String message,
    Color background, [
    Duration? duration,
  ]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: background,
        behavior: SnackBarBehavior.floating,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) =>
      _show(context, message, Colors.green.shade600);

  static void showWarning(BuildContext context, String message) =>
      _show(context, message, Colors.orange.shade700);

  static void showError(BuildContext context, String message) =>
      _show(context, message, Colors.redAccent);

  static void showInfo(BuildContext context, String message) =>
      _show(context, message, Colors.blueGrey.shade600);
}
