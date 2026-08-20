import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/localization/app_translations.dart';
import 'locale_state.dart';
import 'dart:ui';

class LocaleController extends Cubit<LocaleState> {
  static const _storage = FlutterSecureStorage();
  static const _key = 'APP_LOCALE';
  static const supported = ['ar', 'en', 'ku'];
  static const _firstLaunchKey = 'LANG_SELECTED';

  LocaleController() : super(const LocaleState(Locale('ar'), "ar"));

  String getLocaleName(String code) {
    String lang = "ar";
    switch (code) {
      case 'en':
        lang = "english";
        break;

      case 'ar':
        lang = "arabic";
        break;

      case 'ku':
        lang = "kurdish";
        break;

      default:
        lang = "arabic";
        break;
    }
    return lang;
  }

  Future<void> loadSavedLocale() async {
    final saved = await _storage.read(key: _key);
    if (saved != null) {
      AppTranslations.locale = Locale(saved);
      String langName = getLocaleName(saved);
      emit(LocaleState(Locale(saved), langName));
      return;
    }

    final deviceLanguage = PlatformDispatcher.instance.locale.languageCode;

    final locale = supported.contains(deviceLanguage) ? deviceLanguage : 'en';
    AppTranslations.locale = Locale(locale);
    String langName = getLocaleName(locale);

    emit(LocaleState(Locale(locale), langName));
  }

  Future<void> selectAndFinishFirstLaunch(String languageCode) async {
    await Future.wait([
      _storage.write(key: _key, value: languageCode),
      _storage.write(key: _firstLaunchKey, value: 'true'),
    ]);
    AppTranslations.locale = Locale(languageCode);
    String langName = getLocaleName(languageCode);

    emit(LocaleState(Locale(languageCode), langName));
  }
}
