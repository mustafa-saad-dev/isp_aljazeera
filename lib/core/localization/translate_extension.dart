import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_translations.dart';
import '../../controllers/locale/locale_controller.dart';

extension TranslateExtension on BuildContext {
  String tr(String key) {
    final languageCode = read<LocaleController>().state.locale.languageCode;
    return AppTranslations.translate(languageCode, key);
  }
}
