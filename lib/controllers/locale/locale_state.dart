import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LocaleState extends Equatable {
  final Locale locale;
  final String langName;
  const LocaleState(this.locale, this.langName);

  bool get isRtl => locale.languageCode == 'ar';

  @override
  List<Object?> get props => [locale];
}
