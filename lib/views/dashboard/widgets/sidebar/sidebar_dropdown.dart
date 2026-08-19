import 'package:flutter/material.dart';

const Color _kActiveBg = Color(0xFF2B2F36);
const Color _kInactiveColor = Color(0xFFB9BEC7);
const Color _kAccent = Color(0xFFF26522);

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
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── parent item ─────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          child: Material(
            color: widget.active ? _kActiveBg : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            child: InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: widget.collapsed ? null : _toggle,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.collapsed ? 0 : 14,
                  vertical: widget.collapsed ? 11 : 13,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: widget.active
                      ? Border(
                          right: isRtl
                              ? BorderSide.none
                              : const BorderSide(color: _kAccent, width: 3),
                          left: isRtl
                              ? const BorderSide(color: _kAccent, width: 3)
                              : BorderSide.none,
                        )
                      : null,
                ),
                child: widget.collapsed
                    ? Center(
                        child: Icon(
                          widget.icon,
                          size: 20,
                          color: widget.active ? _kAccent : _kInactiveColor,
                        ),
                      )
                    : Row(
                        children: [
                          Icon(
                            widget.icon,
                            size: 18,
                            color: widget.active ? _kAccent : _kInactiveColor,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.label,
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: widget.active
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: widget.active
                                    ? Colors.white
                                    : _kInactiveColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          AnimatedRotation(
                            turns: _open ? 0.5 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              size: 16,
                              color:
                                  _kInactiveColor.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
        // ── children (animated) ─────────────────────────────────
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
