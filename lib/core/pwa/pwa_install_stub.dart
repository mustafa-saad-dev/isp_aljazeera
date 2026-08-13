import 'package:flutter/foundation.dart' show ValueNotifier;

class PwaInstall {
  PwaInstall._();

  static Future<void> init() async {}

  static bool get canInstall => false;

  static Future<void> install() async {}

  static final ValueNotifier<bool> notifier = ValueNotifier<bool>(false);
}
