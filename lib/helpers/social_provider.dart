import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class SocialProvider {
  final String id;
  final String label;
  final Color color;
  final IconData icon;

  const SocialProvider({
    required this.id,
    required this.label,
    required this.color,
    required this.icon,
  });

  static const google = SocialProvider(
    id: 'google',
    label: 'Google',
    color: Color(0xFFEA4335),
    icon: HugeIcons.strokeRoundedGoogle,
  );

  static const facebook = SocialProvider(
    id: 'facebook',
    label: 'Facebook',
    color: Color(0xFF1877F2),
    icon: HugeIcons.strokeRoundedFacebook01,
  );

  static const apple = SocialProvider(
    id: 'apple',
    label: 'Apple',
    color: Color(0xFF2C2C2A),
    icon: HugeIcons.strokeRoundedApple,
  );

  static const all = [google, facebook, apple];

  static bool get isSupported {
    if (kIsWeb) return true;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return true;
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        return false;
    }
  }
}
