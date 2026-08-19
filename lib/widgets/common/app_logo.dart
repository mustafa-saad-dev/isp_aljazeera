import 'package:flutter/material.dart';

import '../../core/helpers/assets_helper.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 84});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.logo,
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }
}
