import 'package:flutter/material.dart';

const Color _kActiveBg = Color(0xFF2B2F36);
const Color _kInactiveColor = Color(0xFFB9BEC7);
const Color _kAccent = Color(0xFFF26522);

class SidebarItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Tooltip(
      message: collapsed ? label : '',
      preferBelow: false,
      waitDuration: const Duration(milliseconds: 400),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
        child: Material(
          color: active ? _kActiveBg : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: collapsed ? 0 : 14,
                vertical: collapsed ? 11 : 13,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: active
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
              child: collapsed
                  ? Center(
                      child: Icon(
                        icon,
                        size: 20,
                        color: active ? _kAccent : _kInactiveColor,
                      ),
                    )
                  : Row(
                      children: [
                        Icon(
                          icon,
                          size: 18,
                          color: active ? _kAccent : _kInactiveColor,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: active
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color:
                                  active ? Colors.white : _kInactiveColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (showDropdown)
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 16,
                            color: _kInactiveColor.withValues(alpha: 0.6),
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
