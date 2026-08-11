import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color success;
  final Color warning;
  final Color info;
  final Color amber;
  final Color green;
  final Color white;
  final Color black;
  final Color teal;
  final Color indigo;
  final Color purple;

  const AppColors({
    required this.success,
    required this.amber,
    required this.warning,
    required this.info,
    required this.green,
    required this.teal,
    required this.white,
    required this.black,
    required this.indigo,
    required this.purple,
  });

  static const light = AppColors(
    success: Color(0xff22C55E),
    warning: Color(0xffF59E0B),
    info: Color(0xff3B82F6),
    amber: Colors.amber,
    green: Colors.green,
    teal: Colors.teal,
    white: Colors.white,
    black: Colors.black,
    indigo: Colors.indigo,
    purple: Color(0xff8B5CF6),
  );

  static const dark = AppColors(
    success: Color(0xff4ADE80),
    warning: Color(0xffFBBF24),
    info: Color(0xff60A5FA),
    amber: Colors.amber,
    green: Colors.green,
    teal: Colors.teal,
    white: Colors.white,
    black: Colors.black,
    indigo: Colors.indigo,
    purple: Color(0xff8B5CF6),
  );

  @override
  AppColors copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? amber,
    Color? green,
    Color? teal,
    Color? white,
    Color? black,
    Color? indigo,
    Color? purple,
  }) {
    return AppColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      amber: amber ?? this.amber,
      green: green ?? this.green,
      teal: teal ?? this.teal,
      white: white ?? this.white,
      black: black ?? this.black,
      indigo: indigo ?? this.indigo,
      purple: purple ?? this.purple,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
      teal: Color.lerp(teal, other.teal, t)!,
      green: Color.lerp(green, other.green, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      indigo: Color.lerp(indigo, other.indigo, t)!,
      purple: Color.lerp(purple, other.purple, t)!,
    );
  }
}
