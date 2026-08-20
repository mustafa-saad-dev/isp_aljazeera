import 'package:flutter/material.dart';
import '../../core/localization/app_translations.dart';
import '../../core/theme/app_theme.dart';

class StatCard extends StatefulWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard>
    with SingleTickerProviderStateMixin {
  bool _hovering = false;
  late final AnimationController _shimmerCtrl;

  @override
  void initState() {
    super.initState();
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.color;
    final isDark = context.theme.brightness == Brightness.dark;
    final colors = context.colors;
    final spacing = context.spacing;
    final shadows = context.shadows;
    final scheme = context.colorScheme;

    final cardBg = scheme.surface;
    final valueColor = scheme.onSurface;
    final labelColor = isDark ? colors.info : const Color(0xFF64748B);
    final borderColor = isDark
        ? colors.info.withValues(alpha: 0.12)
        : scheme.onSurface.withValues(alpha: 0.08);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovering ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            height: 160,
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: AppRadius.largeAll,
              border: Border.all(
                color: _hovering
                    ? c.withValues(alpha: 0.4)
                    : borderColor,
              ),
              boxShadow: _hovering
                  ? [
                      BoxShadow(
                        color: c.withValues(alpha: 0.18),
                        blurRadius: 28,
                        offset: const Offset(0, 6),
                        spreadRadius: 1,
                      ),
                      ...shadows.md,
                    ]
                  : shadows.card,
            ),
            child: ClipRRect(
              borderRadius: AppRadius.largeAll,
              child: Stack(
                children: [
                  // ── decorative circle top-right ──
                  Positioned(
                    top: -spacing.xl,
                    right: -spacing.xl,
                    child: _decorativeCircle(c, 110, isDark ? 0.10 : 0.07),
                  ),

                  // ── decorative circle bottom-left ──
                  Positioned(
                    bottom: -40,
                    left: -spacing.lg,
                    child: _decorativeCircle(c, 90, isDark ? 0.06 : 0.04),
                  ),

                  // ── shimmer top bar ──
                  AnimatedBuilder(
                    animation: _shimmerCtrl,
                    builder: (context, _) {
                      return Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 3,
                        child: FractionallySizedBox(
                          widthFactor: 0.35,
                          alignment: Alignment(
                            -1.0 + 2.0 * _shimmerCtrl.value,
                            0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(8),
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  c.withValues(alpha: 0.0),
                                  c.withValues(alpha: 0.8),
                                  c.withValues(alpha: 0.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // ── content ──
                  Padding(
                    padding: EdgeInsets.all(spacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // icon container
                            Container(
                              width: spacing.lg * 2,
                              height: spacing.lg * 2,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    c.withValues(alpha: 0.18),
                                    c.withValues(alpha: 0.08),
                                  ],
                                ),
                                borderRadius: AppRadius.mediumAll,
                              ),
                              child: Icon(widget.icon, size: 24, color: c),
                            ),
                            const Spacer(),
                            // trend badge
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spacing.sm + 2,
                                vertical: spacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: c.withValues(alpha: isDark ? 0.12 : 0.08),
                                borderRadius: AppRadius.smallAll,
                              ),
                              child: Icon(
                                Icons.trending_up_rounded,
                                size: 14,
                                color: c,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // value
                        Text(
                          widget.value,
                          style: context.typography.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: valueColor,
                            height: 1.0,
                            letterSpacing: -1.0,
                          ),
                        ),
                        SizedBox(height: spacing.sm - 2),
                        // label
                        Text(
                          AppTranslations.tr(widget.label),
                          style: context.typography.bodySmall?.copyWith(
                            color: labelColor,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _decorativeCircle(Color c, double size, double alpha) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            c.withValues(alpha: alpha),
            c.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}
