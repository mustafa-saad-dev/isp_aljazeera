import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfo {
  final String appVersion;
  final String buildNumber;
  final String osVersion;

  const DeviceInfo({
    required this.appVersion,
    required this.buildNumber,
    final String? osVersion,
  }) : osVersion = osVersion ?? '';

  String get summary => '$osVersion · الإصدار $appVersion ($buildNumber)';
}

class DeviceInfoService {
  DeviceInfoService._();

  static final DeviceInfoService instance = DeviceInfoService._();

  static DeviceInfo? _cached;

  static DeviceInfo? get cached => _cached;

  static Future<DeviceInfo> load() async {
    _cached = await instance.getInfo();
    return _cached!;
  }

  final DeviceInfoPlugin _plugin = DeviceInfoPlugin();

  Future<DeviceInfo> getInfo() async {
    final pkg = await PackageInfo.fromPlatform();
    final device = await _plugin.deviceInfo;

    String os = '';

    if (device is AndroidDeviceInfo) {
      os = 'Android ${device.version.release}';
    } else if (device is IosDeviceInfo) {
      os = '${device.systemName} ${device.systemVersion}';
    } else if (device is WindowsDeviceInfo) {
      os = 'Windows ${device.majorVersion}.${device.minorVersion}';
    } else if (device is MacOsDeviceInfo) {
      os = 'macOS ${device.osRelease}';
    } else if (device is LinuxDeviceInfo) {
      os = 'Linux';
    } else if (device is WebBrowserInfo) {
      os = device.platform ?? '';
    }

    return DeviceInfo(
      appVersion: pkg.version,
      buildNumber: pkg.buildNumber,
      osVersion: os,
    );
  }
}
