import 'package:flutter/material.dart';

const Color _kInactiveColor = Color(0xFFB9BEC7);

class SidebarSubItem extends StatelessWidget {
  const SidebarSubItem({
    super.key,
    required this.label,
    this.active = false,
    this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      child: Material(
        color: active ? const Color(0xFF2B2F36) : Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                color: active ? Colors.white : _kInactiveColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
