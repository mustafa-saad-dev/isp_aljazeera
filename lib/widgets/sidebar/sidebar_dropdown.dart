import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SidebarDropdown extends StatefulWidget {
  const SidebarDropdown({
    super.key,
    required this.icon,
    required this.label,
    required this.children,
    this.active = false,
    this.collapsed = false,
    this.initiallyOpen = false,
  });

  final IconData icon;
  final String label;
  final List<Widget> children;
  final bool active;
  final bool collapsed;
  final bool initiallyOpen;

  @override
  State<SidebarDropdown> createState() => _SidebarDropdownState();
}

class _SidebarDropdownState extends State<SidebarDropdown>
    with SingleTickerProviderStateMixin {
  late bool _open;
  bool _hovered = false;
  bool _pressed = false;
  late AnimationController _anim;
  late Animation<double> _heightAnim;

  @override
  void initState() {
    super.initState();
    _open = widget.initiallyOpen;
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _heightAnim = CurvedAnimation(parent: _anim, curve: Curves.easeInOut);
    if (_open) _anim.value = 1.0;
  }

  @override
  void didUpdateWidget(covariant SidebarDropdown old) {
    super.didUpdateWidget(old);
    if (widget.collapsed && _open) {
      _open = false;
      _anim.reverse();
    }
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _anim.forward();
      } else {
        _anim.reverse();
      }
    });
  }

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
        : _hovered
        ? hoverBg
        : Colors.transparent;

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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
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
            onTap: widget.collapsed ? null : _toggle,
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
                    ? Center(
                        child: Icon(widget.icon, size: 20, color: iconColor),
                      )
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
                          AnimatedRotation(
                            turns: _open ? 0.5 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              size: 16,
                              color: muted,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
        SizeTransition(
          sizeFactor: _heightAnim,
          alignment: AlignmentDirectional(-1, 0),
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: widget.collapsed ? 0 : 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.children,
            ),
          ),
        ),
      ],
    );
  }
}
