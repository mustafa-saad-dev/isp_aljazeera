import 'package:flutter/widgets.dart';

import '../../core/localization/app_translations.dart';

extension BuildContextTranslate on BuildContext {
  String tr(String key) => AppTranslations.tr(key);
}
