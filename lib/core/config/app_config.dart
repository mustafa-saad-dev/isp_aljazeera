import 'package:flutter/foundation.dart';

class AppConfig {
  AppConfig._();

  static const String mineBaseUrl = 'https://api.example.com';

  static const String sasradiusBaseUrl = 'https://sasradius.example.com';

  static const bool useFakeApi = true;

  // Update / store links per platform
  static const String androidUpdateUrl =
      'https://play.google.com/store/apps/details?id=com.example.isp_aljazeera';
  static const String iosUpdateUrl = 'https://apps.apple.com/app/idXXXXXXXXXX';
  static const String windowsUpdateUrl = 'https://example.com/download/windows';

  static String updateUrlForPlatform(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return androidUpdateUrl;
      case TargetPlatform.iOS:
        return iosUpdateUrl;
      case TargetPlatform.windows:
        return windowsUpdateUrl;
      default:
        return '';
    }
  }
}
