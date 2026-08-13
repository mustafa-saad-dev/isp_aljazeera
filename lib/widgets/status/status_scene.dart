import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/decorative_dot.dart';

class StatusScene extends StatelessWidget {
  const StatusScene({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
    this.buttonLabel,
    this.onButton,
  });

  final IconData icon;
  final String title;
  final String desc;
  final String? buttonLabel;
  final VoidCallback? onButton;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final typography = context.typography;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 220,
            height: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        scheme.primary.withValues(alpha: .10),
                        scheme.primary.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: scheme.primary.withValues(alpha: .12),
                      width: 1.4,
                    ),
                  ),
                ),
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        scheme.primary.withValues(alpha: .14),
                        scheme.primary.withValues(alpha: .05),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 28,
                  right: 34,
                  child: DecorativeDot(color: scheme.primary, opacity: .35),
                ),
                Positioned(
                  bottom: 36,
                  left: 30,
                  child: DecorativeDot(
                    color: scheme.primary,
                    opacity: .2,
                    size: 7,
                  ),
                ),
                Icon(icon, size: 78, color: scheme.primary),
              ],
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: typography.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: scheme.onSurface,
              letterSpacing: -.2,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              desc,
              textAlign: TextAlign.center,
              style: typography.bodyMedium?.copyWith(
                color: scheme.onSurfaceVariant,
                height: 1.65,
                fontSize: 11.5,
              ),
            ),
          ),
          const SizedBox(height: 30),
          if (onButton != null && buttonLabel != null)
            SizedBox(
              width: 180,
              child: AppButton(
                height: 44,
                label: buttonLabel!,
                onPressed: onButton,
              ),
            ),
        ],
      ),
    );
  }
}
