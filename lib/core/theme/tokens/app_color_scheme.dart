import 'package:flutter/material.dart';

 
class AppColorScheme {
  AppColorScheme._();

  static const light = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff378ADD),
    onPrimary: Colors.white,
    secondary: Color(0xff1D9E75),
    onSecondary: Colors.white,
    error: Color(0xffA32D2D),
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xff2C2C2A),
    tertiary: Color(0xffBA7517),
    onTertiary: Colors.white,
  );

  static const dark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff85B7EB),
    onPrimary: Color(0xff042C53),
    secondary: Color(0xff5DCAA5),
    onSecondary: Color(0xff04342C),
    error: Color(0xffF09595),
    onError: Color(0xff501313),
    surface: Color(0xff1C1B18),
    onSurface: Color(0xffF1EFE8),
    tertiary: Color(0xffEF9F27),
    onTertiary: Color(0xff412402),
  );
}
