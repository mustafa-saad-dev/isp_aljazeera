import 'package:flutter/material.dart';

class AppShadows {
  final List<BoxShadow> card;

  const AppShadows({required this.card});

  static const light = AppShadows(
    card: [
      BoxShadow(color: Color(0x14000000), blurRadius: 12, offset: Offset(0, 4)),
    ],
  );

  static const dark = AppShadows(
    card: [
      BoxShadow(color: Color(0x33000000), blurRadius: 12, offset: Offset(0, 4)),
    ],
  );
}
