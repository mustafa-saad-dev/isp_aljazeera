import 'package:flutter/material.dart';

 
class AppColorScheme {
  AppColorScheme._();

  static const light = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFF26522),
    onPrimary: Colors.white,
    secondary: Color(0xFF22262C),
    onSecondary: Colors.white,
    error: Color(0xffEF5F5F),
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xff111827),
    tertiary: Color(0xff5C6FC0),
    onTertiary: Colors.white,
  );

  static const dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFF26522),
    onPrimary: Colors.white,
    secondary: Color(0xFF2D3142),
    onSecondary: Colors.white,
    error: Color(0xffF09595),
    onError: Color(0xff501313),
    surface: Color(0xff1A1D23),
    onSurface: Color(0xffF1EFE8),
    tertiary: Color(0xffEF9F27),
    onTertiary: Color(0xff412402),
  );
}
