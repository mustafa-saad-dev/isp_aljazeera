import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SidebarItem extends StatefulWidget {
  const SidebarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.active,
    this.onTap,
    this.showDropdown = false,
    this.collapsed = false,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;
  final bool showDropdown;
  final bool collapsed;

  @override
  State<SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = context.colorScheme;
    final typo = context.typography;

    final accent = scheme.primary;
    final sidebarBg = scheme.secondary;
    final onSidebar = scheme.onSecondary;
    final muted = onSidebar.withValues(alpha: 0.55);

    final activeBg = Color.lerp(sidebarBg, onSidebar, 0.08)!;
    final hoverBg = Color.lerp(sidebarBg, onSidebar, 0.06)!;

    final bgColor = widget.active
        ? activeBg
        : (_hovered ? hoverBg : Colors.transparent);
    final iconColor = widget.active ? accent : (_hovered ? onSidebar : muted);
    final textColor = widget.active
        ? onSidebar
        : (_hovered ? onSidebar : muted);

    final borderSide = BorderSide(color: accent, width: 3);
    final border = widget.active ? BorderDirectional(start: borderSide) : null;

    final bodyStyle = typo.bodySmall?.copyWith(
      fontWeight: widget.active ? FontWeight.w700 : FontWeight.w500,
      color: textColor,
    );

    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.smallAll,
        border: border,
      ),
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
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: EdgeInsets.symmetric(
              horizontal: widget.collapsed ? 0 : 14,
              vertical: widget.collapsed ? 11 : 13,
            ),
            child: widget.collapsed
                ? Center(child: Icon(widget.icon, size: 20, color: iconColor))
                : Row(
                    children: [
                      Icon(widget.icon, size: 18, color: iconColor),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.label,
                          style: bodyStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (widget.showDropdown)
                        Icon(Icons.keyboard_arrow_down, size: 16, color: muted),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
