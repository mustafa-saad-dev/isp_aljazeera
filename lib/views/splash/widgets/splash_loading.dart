import 'package:flutter/material.dart';

import '../../../core/device/device_info_service.dart';
import '../../../core/localization/app_translations.dart';
import '../../../widgets/common/app_loading.dart';

class SplashLoading extends StatelessWidget {
  const SplashLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final device = DeviceInfoService.cached;

    return AppLoading(
      tagline: AppTranslations.tr('loading'),
      footer: device == null
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                device.summary,
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
