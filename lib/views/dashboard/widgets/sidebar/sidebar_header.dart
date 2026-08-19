import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

import '../../../../core/localization/app_translations.dart';

class SidebarHeader extends StatelessWidget {
  const SidebarHeader({super.key, this.collapsed = false});

  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      color: scheme.secondary,
      child: collapsed
          ? Center(child: Icon(Icons.wifi, color: scheme.primary, size: 26))
          : Row(
              children: [
                Icon(Icons.wifi, color: scheme.primary, size: 26),
                const SizedBox(width: 10),
                Text(
                  AppTranslations.tr('appName'),
                  style: context.typography.titleLarge?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
    );
  }
}
