import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/helpers/assets_helper.dart';
import '../../core/localization/app_translations.dart';
import '../../core/theme/tokens/app_brand.dart';

class AppLoadingBody extends StatelessWidget {
  final String? tagline;
  final Widget? footer;
  final double size;
  const AppLoadingBody({super.key, this.tagline, this.footer, this.size = 156});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OrbitDots(size: size),
          const SizedBox(height: 18),
          const GradientText(
            'Subnex',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            tagline ?? AppTranslations.tr('loading'),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF7D93AD),
              letterSpacing: 0.3,
            ),
          ),
          if (footer != null) ...[const SizedBox(height: 20), footer!],
        ],
      ),
    );
  }
}

class AppLoading extends StatelessWidget {
  final String? tagline;
  final Widget? footer;
  final double size;

  const AppLoading({super.key, this.tagline, this.footer, this.size = 156});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AppLoadingBody(tagline: tagline, footer: footer, size: size),
    );
  }
}

class OrbitDots extends StatefulWidget {
  final double size;
  final double logoSize;
  const OrbitDots({super.key, this.size = 156, this.logoSize = 96});

  @override
  State<OrbitDots> createState() => _OrbitDotsState();
}

class _OrbitDotsState extends State<OrbitDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  )..repeat();

  static const List<double> _opacity = [
    1,
    0.9,
    0.78,
    0.66,
    0.55,
    0.45,
    0.36,
    0.28,
    0.22,
    0.18,
    0.18,
    0.18,
  ];

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.of(context).disableAnimations;
    final r = widget.size / 2 - 12;
    final dot = 7.0;

    final dots = List.generate(12, (i) {
      final a = (i * 30 - 90) * pi / 180;
      final cx = widget.size / 2 + r * cos(a);
      final cy = widget.size / 2 + r * sin(a);
      return Positioned(
        left: cx - dot / 2,
        top: cy - dot / 2,
        child: Container(
          width: dot,
          height: dot,
          decoration: BoxDecoration(
            color: AppBrand.brand.withValues(alpha: _opacity[i]),
            shape: BoxShape.circle,
          ),
        ),
      );
    });

    final orbit = SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(children: dots),
    );

    final logo = ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        AppAssets.logo,
        width: widget.logoSize,
        height: widget.logoSize,
        fit: BoxFit.contain,
      ),
    );

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (reduce) orbit else RotationTransition(turns: _ctrl, child: orbit),
          logo,
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
}

/// نص بتدرّج لوني (علامة تجارية).
class GradientText extends StatelessWidget {
  const GradientText(this.text, {super.key, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        colors: [AppBrand.brandStrong, AppBrand.accent],
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(text, style: style.copyWith(color: Colors.white)),
    );
  }
}
