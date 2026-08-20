import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SidebarNestedDropdown extends StatefulWidget {
  const SidebarNestedDropdown({
    super.key,
    required this.label,
    required this.children,
    this.active = false,
    this.collapsed = false,
  });

  final String label;
  final List<Widget> children;
  final bool active;
  final bool collapsed;

  @override
  State<SidebarNestedDropdown> createState() => _SidebarNestedDropdownState();
}

class _SidebarNestedDropdownState extends State<SidebarNestedDropdown>
    with SingleTickerProviderStateMixin {
  bool _open = false;
  bool _hovered = false;
  bool _pressed = false;
  late AnimationController _anim;
  late Animation<double> _heightAnim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _heightAnim = CurvedAnimation(parent: _anim, curve: Curves.easeInOut);
  }

  @override
  void didUpdateWidget(covariant SidebarNestedDropdown old) {
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

    final textColor = widget.active
        ? onSidebar
        : (_hovered ? onSidebar : muted);

    final borderSide = BorderSide(color: accent, width: 3);
    final border = widget.active ? Border(right: borderSide) : null;

    final bodyStyle = typo.bodySmall?.copyWith(
      fontWeight: widget.active ? FontWeight.w700 : FontWeight.w400,
      color: textColor,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: AppRadius.smallAll,
            border: border,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: widget.collapsed
                    ? Center(child: Icon(Icons.circle, size: 6, color: muted))
                    : Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.label,
                              style: bodyStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          AnimatedRotation(
                            turns: _open ? 0.5 : 0,
                            duration: const Duration(milliseconds: 180),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              size: 14,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.children,
          ),
        ),
      ],
    );
  }
}
