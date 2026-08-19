import 'package:flutter/material.dart';
import 'package:isp_aljazeera/core/theme/app_theme.dart';
import '../../widgets/common/app_logo.dart';

class AuthCardShell extends StatelessWidget {
  const AuthCardShell({
    super.key,
    required this.subtitle,
    required this.children,
    this.topBar,
  });

  final String subtitle;
  final List<Widget> children;
  final Widget? topBar;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final textTheme = context.typography;

    return ClipRRect(
      borderRadius: AppRadius.mediumAll,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: AppRadius.mediumAll,
          border: Border.all(color: scheme.onSurface.withValues(alpha: 0.08)),
          boxShadow: context.shadows.card,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(child: AppLogo(size: 90)),
                  const SizedBox(height: 14),
                  Text(
                    'MY NET',
                    style: textTheme.headlineMedium?.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: scheme.primary,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      height: 1.5,
                      color: scheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ...children,
                ],
              ),
            ),
            if (topBar != null)
              Positioned(top: 14, left: 14, right: 14, child: topBar!),
          ],
        ),
      ),
    );
  }
}
