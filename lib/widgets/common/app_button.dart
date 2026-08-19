import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AppButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double height;
  final double? width;
  final bool isLoading;
  final bool fullWidth;
  final BorderRadius borderRadius;
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.height = 48,
    this.width,
    this.isLoading = false,
    this.fullWidth = false,
    this.borderRadius = AppRadius.smallAll,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final onColor = scheme.onPrimary;

    final children = <Widget>[];
    children.add(Text(widget.label));

    if (widget.icon != null || widget.isLoading) {
      children.add(const SizedBox(width: 8));
      children.add(_iconSlot(onColor));
    }

    final content = Row(mainAxisSize: MainAxisSize.min, children: children);

    final btn = ElevatedButton(
      onPressed: widget.isLoading ? null : widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: onColor,
        disabledBackgroundColor: scheme.primary.withValues(alpha: 0.5),
        disabledForegroundColor: onColor.withValues(alpha: 0.7),
        elevation: 6,
        shadowColor: scheme.primary.withValues(alpha: 0.45),
        iconAlignment: IconAlignment.end,
        shape: RoundedRectangleBorder(borderRadius: widget.borderRadius),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
      child: content,
    );

    return SizedBox(
      height: widget.height,
      width: widget.fullWidth ? double.infinity : widget.width,
      child: btn,
    );
  }

  Widget _iconSlot(Color onColor) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: animation, child: child),
      ),
      child: widget.isLoading
          ? SizedBox(
              key: const ValueKey('spin'),
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                strokeCap: StrokeCap.round,
                valueColor: AlwaysStoppedAnimation(onColor),
                backgroundColor: onColor.withValues(alpha: 0.35),
              ),
            )
          : Icon(widget.icon, size: 18, key: const ValueKey('icon')),
    );
  }
}
