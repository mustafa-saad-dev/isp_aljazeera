import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../widgets/common/app_button.dart';
import '../../../core/device/device_info_service.dart';
import '../../../core/localization/app_translations.dart';
import '../../../core/theme/extensions/context_theme_extension.dart';
import '../../../core/theme/tokens/app_radius.dart';
import '../../../models/app/app_version_model/app_version_model.dart';

class SplashUpdateDialog {
  SplashUpdateDialog._();

  static Future<void> show(
    BuildContext context, {
    required AppVersionModel update,
    required bool forced,
    VoidCallback? onUpdate,
  }) {
    final scheme = context.colorScheme;
    final primary = scheme.primary;

    return showDialog<void>(
      context: context,
      barrierDismissible: !forced,
      builder: (ctx) => Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(24),
        child: Container(
          constraints: BoxConstraints(maxWidth: 350),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: AppRadius.mediumAll,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.1),
                  borderRadius: AppRadius.mediumAll,
                ),
                child: Icon(
                  HugeIcons.strokeRoundedCloudDownload,
                  color: primary,
                  size: 28,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                AppTranslations.tr('updateTitle'),
                style: context.typography.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                update.description,
                style: context.typography.bodyMedium?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.6),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              if (DeviceInfoService.cached != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.onSurface.withValues(alpha: 0.05),
                    borderRadius: AppRadius.smallAll,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.smartphone_rounded,
                        size: 15,
                        color: scheme.outline,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          '${AppTranslations.tr('device')}: ${DeviceInfoService.cached!.summary}',
                          style: context.typography.labelSmall?.copyWith(
                            color: scheme.onSurface.withValues(alpha: 0.6),
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (onUpdate != null) ...[
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: AppTranslations.tr('update'),
                    height: 45,
                    icon: HugeIcons.strokeRoundedDownload02,
                    onPressed: () {
                      Navigator.of(context).pop();
                      onUpdate();
                    },
                  ),
                ),
              ],
              if (!forced || onUpdate == null) ...[
                const SizedBox(height: 6),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(
                    AppTranslations.tr('later'),
                    style: context.typography.labelLarge?.copyWith(
                      color: scheme.outline,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
