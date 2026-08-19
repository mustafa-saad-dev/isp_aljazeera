import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/api/api1/api1.dart';
import '../../core/api/api1/api1_endpoint.dart';
import '../../core/device/device_info_service.dart';
import '../../core/localization/app_translations.dart';
import '../../models/app/app_version_model/app_version_model.dart';

class AppUpdateService {
  AppUpdateService._();

  static final AppUpdateService instance = AppUpdateService._();

  bool _isLower(String current, String latest) {
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

  String _platformKey() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'android';
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.windows:
        return 'windows';
      default:
        return '';
    }
  }

  Future<AppVersionModel?> checkForUpdate() async {
    try {
      final res = await Api1.dio.get(Api1Endpoints.checkUpdate);
      return AppVersionModel.fromJson(res.data);
    } catch (_) {
      return null;
    }
  }

  Future<bool> needsUpdate() async {
    final device = await DeviceInfoService.instance.getInfo();
    final current = device.appVersion;
    final version = await checkForUpdate();
    if (version == null) return false;
    return _isLower(current, version.versionName);
  }

  String getDownloadUrl(AppVersionModel version) {
    return version.urlForPlatform(_platformKey());
  }

  String getUpdateMessage(AppVersionModel version) {
    return version.title.isNotEmpty
        ? version.title
        : AppTranslations.tr('updateAvailableMsg');
  }

  static Future<void> openUpdateUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
