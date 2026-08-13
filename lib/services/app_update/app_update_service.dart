import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/config/app_config.dart';
import '../../core/device/device_info_service.dart';
import '../../core/localization/app_translations.dart';

class UpdateInfo {
  final bool hasUpdate;
  final bool required;
  final String currentVersion;
  final String latestVersion;
  final String message;
  final String downloadUrl;

  const UpdateInfo({
    required this.hasUpdate,
    required this.required,
    required this.currentVersion,
    required this.latestVersion,
    required this.message,
    required this.downloadUrl,
  });
}

class AppUpdateService {
  AppUpdateService._();

  static final AppUpdateService instance = AppUpdateService._();

  bool isLower(String current, String latest) {
    final a = current.split('.').map(int.tryParse).whereType<int>().toList();
    final b = latest.split('.').map(int.tryParse).whereType<int>().toList();
    final len = a.length > b.length ? a.length : b.length;
    for (var i = 0; i < len; i++) {
      final x = i < a.length ? a[i] : 0;
      final y = i < b.length ? b[i] : 0;
      if (x != y) return x < y;
    }
    return false;
  }

  Future<UpdateInfo> checkForUpdate() async {
    final device = await DeviceInfoService.instance.getInfo();
    final current = device.appVersion;
    final latest = '1.1.0';
    final downloadUrl = AppConfig.updateUrlForPlatform(defaultTargetPlatform);

    if (AppConfig.useFakeApi) {
      await Future.delayed(const Duration(milliseconds: 700));
      final hasUpdate = isLower(current, latest);
      return UpdateInfo(
        hasUpdate: hasUpdate,
        required: false,
        currentVersion: current,
        latestVersion: latest,
        message: hasUpdate
            ? AppTranslations.tr('updateAvailableMsg')
            : AppTranslations.tr('upToDateMsg'),
        downloadUrl: downloadUrl,
      );
    }

    return UpdateInfo(
      hasUpdate: false,
      required: false,
      currentVersion: current,
      latestVersion: current,
      message: '',
      downloadUrl: downloadUrl,
    );
  }

  static Future<void> openUpdateUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
