import 'package:flutter/material.dart';

import '../../core/localization/translate_extension.dart';
import '../../widgets/status/status_scene.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, this.onRetry, this.message, this.actionLabel});

  final VoidCallback? onRetry;
  final String? message;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return StatusScene(
      icon: Icons.inbox_outlined,
      title: message ?? context.tr('no_data_title'),
      desc: context.tr('no_data_desc'),
      buttonLabel:
          actionLabel ?? (onRetry != null ? context.tr('retry') : null),
      onButton: onRetry,
    );
  }
}
