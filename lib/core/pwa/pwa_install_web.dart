// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:js_interop';

import 'package:web/web.dart';

import 'package:flutter/foundation.dart' show ValueNotifier;

extension type BeforeInstallPromptEvent._(JSObject _) implements JSObject {
  external JSPromise get userChoice;
  external void prompt();
}

class PwaInstall {
  PwaInstall._();

  static BeforeInstallPromptEvent? _event;
  static final ValueNotifier<bool> notifier = ValueNotifier<bool>(false);

  static void init() {
    document.addEventListener(
      'beforeinstallprompt',
      (Event event) {
        event.preventDefault();
        _event = event as BeforeInstallPromptEvent;
        notifier.value = true;
      }.toJS,
    );
    window.addEventListener(
      'appinstalled',
      (Event event) {
        _event = null;
        notifier.value = false;
      }.toJS,
    );
  }

  static bool get canInstall => _event != null;

  static Future<void> install() async {
    final event = _event;
    if (event == null) return;
    event.prompt();
    await event.userChoice.toDart;
    _event = null;
    notifier.value = false;
  }
}
