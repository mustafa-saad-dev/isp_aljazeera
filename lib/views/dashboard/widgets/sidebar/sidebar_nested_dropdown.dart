import 'package:flutter/material.dart';

const Color _kActiveBg = Color(0xFF2B2F36);
const Color _kInactiveColor = Color(0xFFB9BEC7);

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          child: Material(
            color: widget.active ? _kActiveBg : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: widget.collapsed ? null : _toggle,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: widget.collapsed
                    ? Center(
                        child: Icon(
                          Icons.circle,
                          size: 6,
                          color: _kInactiveColor.withValues(alpha: 0.5),
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.label,
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: widget.active
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                                color: widget.active
                                    ? Colors.white
                                    : _kInactiveColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          AnimatedRotation(
                            turns: _open ? 0.25 : 0,
                            duration: const Duration(milliseconds: 180),
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              size: 14,
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
        SizeTransition(
          sizeFactor: _heightAnim,
          alignment: AlignmentDirectional(-1, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 14),
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
