import 'package:flutter/material.dart';

class AppAssets {
  AppAssets._();
  static const String imagesDir = 'assets/images/';
  static const String iconsDir = 'assets/icons/';
  static const String logo = '${imagesDir}logo.png';

  static AssetImage get logoProvider => const AssetImage(logo);
}
