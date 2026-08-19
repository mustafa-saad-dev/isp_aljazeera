class AppVersionModel {
  final String title;
  final String description;
  final int versionNumber;
  final String versionName;
  final String androidUrl;
  final String iosUrl;
  final String windowsUrl;
  final bool forceUpdate;
  final DateTime releasedAt;

  AppVersionModel({
    required this.title,
    required this.description,
    required this.versionNumber,
    required this.versionName,
    required this.androidUrl,
    required this.iosUrl,
    required this.windowsUrl,
    required this.forceUpdate,
    required this.releasedAt,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic> ? json['data'] : json;
    return AppVersionModel(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      versionNumber: data['version_number'] ?? 0,
      versionName: data['version_name'] ?? '',
      androidUrl: data['android_url'] ?? '',
      iosUrl: data['ios_url'] ?? '',
      windowsUrl: data['windows_url'] ?? '',
      forceUpdate: data['force_update'] ?? false,
      releasedAt: DateTime.tryParse(data['released_at'] ?? '') ?? DateTime.now(),
    );
  }

  String urlForPlatform(String platform) {
    switch (platform) {
      case 'android':
        return androidUrl;
      case 'ios':
        return iosUrl;
      case 'windows':
        return windowsUrl;
      default:
        return '';
    }
  }
}
