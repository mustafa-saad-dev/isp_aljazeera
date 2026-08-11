class AppSpacing {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  const AppSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  static const standard = AppSpacing(xs: 4, sm: 8, md: 16, lg: 24, xl: 32);
}
