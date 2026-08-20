import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SidebarSubItem extends StatefulWidget {
  final String label;
  final bool active;
  final VoidCallback? onTap;
  const SidebarSubItem({
    super.key,
    required this.label,
    this.active = false,
    this.onTap,
  });

  @override
  State<SidebarSubItem> createState() => _SidebarSubItemState();
}

class _SidebarSubItemState extends State<SidebarSubItem>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final typo = context.typography;

    final accent = scheme.primary;
    final sidebarBg = scheme.secondary;
    final onSidebar = scheme.onSecondary;
    final muted = onSidebar.withValues(alpha: 0.45);

    final activeBg = Color.lerp(sidebarBg, onSidebar, 0.07)!;
    final hoverBg = Color.lerp(sidebarBg, onSidebar, 0.05)!;

    final bgColor = widget.active
        ? activeBg
        : _hovered
        ? hoverBg
        : Colors.transparent;

    final isActive = widget.active;
    final isHover = _hovered;

    final textColor = isActive
        ? onSidebar
        : isHover
        ? onSidebar
        : muted;

    final bodyStyle = typo.bodySmall?.copyWith(
      fontSize: 12.5,
      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
      color: textColor,
      letterSpacing: 0.2,
    );

    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(vertical: 1,horizontal: 0),

      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.smallAll,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppRadius.smallAll,
        child: InkWell(
          borderRadius: AppRadius.smallAll,
          onTap: widget.onTap,
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          onHover: (v) => setState(() => _hovered = v),
          child: AnimatedScale(
            scale: _pressed ? 0.97 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isActive ? 3 : 0,
                    height: 14,
                    margin: const EdgeInsetsDirectional.only(end: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: accent,
                    ),
                  ),
                  if (!isActive)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 0,
                      margin: const EdgeInsetsDirectional.only(end: 0),
                    ),
                  Expanded(
                    child: Text(
                      widget.label,
                      style: bodyStyle,
                      overflow: TextOverflow.ellipsis,
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
}
