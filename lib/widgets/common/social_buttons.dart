import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../core/localization/app_translations.dart';
import '../../core/theme/app_theme.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key, this.onTap});

  final void Function(String provider)? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(color: scheme.onSurface.withValues(alpha: 0.12)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                AppTranslations.tr('orContinueWith'),
                style: TextStyle(
                  fontSize: 13,
                  color: scheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ),
            Expanded(
              child: Divider(color: scheme.onSurface.withValues(alpha: 0.12)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _filled(
              HugeIcons.strokeRoundedFacebook01,
              const Color(0xFF1877F2),
              AppTranslations.tr('continueWithFacebook'),
            ),
            const SizedBox(width: 16),
            _filled(
              HugeIcons.strokeRoundedGoogle,
              const Color(0xFFEA4335),
              AppTranslations.tr('continueWithGoogle'),
            ),
            const SizedBox(width: 16),
            _filled(
              HugeIcons.strokeRoundedApple,
              const Color(0xFF2C2C2A),
              AppTranslations.tr('continueWithApple'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _filled(IconData icon, Color brand, String tooltip) {
    return SizedBox(
      width: 35,
      height: 35,
      child: Tooltip(
        message: tooltip,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap == null ? null : () => onTap!(tooltip),
            borderRadius: BorderRadius.circular(11),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: brand,
                boxShadow: [
                  BoxShadow(
                    color: brand.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: HugeIcon(icon: icon, color: Colors.white, size: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
