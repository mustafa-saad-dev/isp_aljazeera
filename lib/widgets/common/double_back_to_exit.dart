import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../../core/helpers/toast_helper.dart';
import '../../core/localization/app_translations.dart';

class DoubleBackToExit extends StatefulWidget {
  const DoubleBackToExit({super.key, required this.child});

  final Widget child;

  @override
  State<DoubleBackToExit> createState() => _DoubleBackToExitState();
}

class _DoubleBackToExitState extends State<DoubleBackToExit> {
  DateTime? _lastPressed;
  bool _allowExit = false;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return widget.child;

    return PopScope(
      canPop: _allowExit,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        final now = DateTime.now();
        if (_lastPressed != null &&
            now.difference(_lastPressed!) < const Duration(seconds: 2)) {
          _allowExit = true;
          return;
        }
        _lastPressed = now;
        _allowExit = false;
        ToastHelper.showWarning(context, AppTranslations.tr('exitWarning'));
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) setState(() => _allowExit = false);
        });
      },
      child: widget.child,
    );
  }
}
