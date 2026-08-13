import 'package:flutter/material.dart';

import '../../core/localization/translate_extension.dart';
import '../../widgets/status/status_scene.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, this.onRetry, this.message});

  final VoidCallback? onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return StatusScene(
      icon: Icons.error_outline_rounded,
      title: context.tr('error_title'),
      desc: message ?? context.tr('error_desc'),
      buttonLabel: onRetry != null ? context.tr('retry') : null,
      onButton: onRetry,
    );
  }
}
