import 'package:flutter/material.dart';

import '../../core/localization/translate_extension.dart';
import '../../widgets/status/status_scene.dart';

class OfflineView extends StatelessWidget {
  const OfflineView({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return StatusScene(
      icon: Icons.wifi_off_outlined,
      title: context.tr('no_internet_title'),
      desc: context.tr('no_internet_desc'),
      buttonLabel: onRetry != null ? context.tr('retry') : null,
      onButton: onRetry,
    );
  }
}
