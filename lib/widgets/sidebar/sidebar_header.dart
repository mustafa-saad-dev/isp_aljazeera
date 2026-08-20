import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/localization/app_translations.dart';
import '../common/app_logo.dart';

class SidebarHeader extends StatelessWidget {
  const SidebarHeader({super.key, this.collapsed = false});

  final bool collapsed;

  static const double _expandedMinWidth = 92;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final typo = context.typography;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      color: scheme.secondary,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final showCompact =
              collapsed || constraints.maxWidth < _expandedMinWidth;

          if (showCompact) {
            return Center(child: AppLogo(size: 35));
          }

          return Row(
            children: [
              AppLogo(size: 50),
              const SizedBox(width: 10),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    AppTranslations.tr('appName'),
                    style: typo.titleLarge?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
