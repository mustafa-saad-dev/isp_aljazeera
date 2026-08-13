import 'package:flutter/material.dart';
import 'error_keys.dart';

class ErrorTranslator {
  ErrorTranslator._();

  static String resolveKey(String rawMessage) {
    if (ErrorKeys.map.containsKey(rawMessage)) {
      return ErrorKeys.map[rawMessage]!;
    }

    for (final entry in ErrorKeys.map.entries) {
      if (rawMessage.toLowerCase().contains(entry.key.toLowerCase())) {
        return entry.value;
      }
    }

    return ErrorKeys.fallback;
  }

  static String translate(BuildContext context, String rawMessage) {
    final key = resolveKey(rawMessage);

    return key;
  }
}
