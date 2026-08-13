import 'package:flutter/material.dart';

@immutable
class AppShadows extends ThemeExtension<AppShadows> {
  final List<BoxShadow> xs;
  final List<BoxShadow> sm;
  final List<BoxShadow> md;
  final List<BoxShadow> lg;
  final List<BoxShadow> xl;

  final List<BoxShadow> card;

  final List<BoxShadow> dialog;

  const AppShadows({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.card,
    required this.dialog,
  });

  static List<BoxShadow> _scale(
    Color color,
    double baseAlpha,
    double blur,
    double y,
  ) {
    return [
      BoxShadow(
        color: color.withValues(alpha: baseAlpha),
        blurRadius: blur,
        offset: Offset(0, y),
      ),
    ];
  }

  static final light = AppShadows(
    xs: _scale(Colors.black, 0.04, 4, 1),
    sm: _scale(Colors.black, 0.06, 8, 2),
    md: _scale(Colors.black, 0.08, 16, 4),
    lg: _scale(Colors.black, 0.10, 24, 8),
    xl: _scale(Colors.black, 0.14, 40, 16),
    card: _scale(Colors.black, 0.04, 12, 4),
    dialog: _scale(Colors.black, 0.16, 32, 12),
  );

  static final dark = AppShadows(
    xs: _scale(Colors.black, 0.20, 4, 1),
    sm: _scale(Colors.black, 0.26, 8, 2),
    md: _scale(Colors.black, 0.32, 16, 4),
    lg: _scale(Colors.black, 0.38, 24, 8),
    xl: _scale(Colors.black, 0.46, 40, 16),
    card: _scale(Colors.black, 0.24, 12, 4),
    dialog: _scale(Colors.black, 0.48, 32, 12),
  );

  @override
  AppShadows copyWith({
    List<BoxShadow>? xs,
    List<BoxShadow>? sm,
    List<BoxShadow>? md,
    List<BoxShadow>? lg,
    List<BoxShadow>? xl,
    List<BoxShadow>? card,
    List<BoxShadow>? dialog,
  }) {
    return AppShadows(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      card: card ?? this.card,
      dialog: dialog ?? this.dialog,
    );
  }

  @override
  AppShadows lerp(ThemeExtension<AppShadows>? other, double t) {
    if (other is! AppShadows) return this;
    return AppShadows(
      xs: BoxShadow.lerpList(xs, other.xs, t) ?? xs,
      sm: BoxShadow.lerpList(sm, other.sm, t) ?? sm,
      md: BoxShadow.lerpList(md, other.md, t) ?? md,
      lg: BoxShadow.lerpList(lg, other.lg, t) ?? lg,
      xl: BoxShadow.lerpList(xl, other.xl, t) ?? xl,
      card: BoxShadow.lerpList(card, other.card, t) ?? card,
      dialog: BoxShadow.lerpList(dialog, other.dialog, t) ?? dialog,
    );
  }
}
