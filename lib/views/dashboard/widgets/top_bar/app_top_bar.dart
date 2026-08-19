import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_translations.dart';
import '../../../../controllers/theme/theme_controller.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    this.onToggleSidebar,
    this.sidebarCollapsed = false,
  });

  final VoidCallback? onToggleSidebar;
  final bool sidebarCollapsed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;
    final borderColor =
        brightness == Brightness.dark ? const Color(0xFF2A2D35) : const Color(0xFFE5E7EB);
    final titleColor =
        brightness == Brightness.dark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final nameColor =
        brightness == Brightness.dark ? const Color(0xFFE5E7EB) : const Color(0xFF374151);
    final avatarBg =
        brightness == Brightness.dark ? const Color(0xFF374151) : const Color(0xFFD1D5DB);

    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: Row(
        children: [
          // ── sidebar toggle ──────────────────────────────────────
          if (onToggleSidebar != null)
            IconButton(
              onPressed: onToggleSidebar,
              icon: Icon(
                sidebarCollapsed ? Icons.menu : Icons.menu_open,
                size: 20,
                color: titleColor,
              ),
              tooltip: '',
              splashRadius: 18,
            ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              AppTranslations.tr('dashboard'),
              style: TextStyle(fontSize: 14, color: titleColor),
            ),
          ),
          // ── theme toggle ────────────────────────────────────────
          _ThemeToggle(scheme: scheme, titleColor: titleColor),
          const SizedBox(width: 8),
          // ── user avatar + name ──────────────────────────────────
          CircleAvatar(
            radius: 15,
            backgroundColor: avatarBg,
            child: Text(
              'A',
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'admin',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: nameColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle({required this.scheme, required this.titleColor});
  final ColorScheme scheme;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ThemeController>().state.mode;

    IconData icon;
    ThemeMode next;
    String tooltip;

    switch (mode) {
      case ThemeMode.dark:
        icon = Icons.dark_mode_outlined;
        next = ThemeMode.light;
        tooltip = 'light';
        break;
      case ThemeMode.light:
        icon = Icons.light_mode_outlined;
        next = ThemeMode.dark;
        tooltip = 'dark';
        break;
      default:
        icon = Icons.brightness_auto_outlined;
        next = ThemeMode.light;
        tooltip = 'system';
    }

    return IconButton(
      onPressed: () => context.read<ThemeController>().toggleTheme(next),
      icon: Icon(icon, size: 20, color: titleColor),
      tooltip: tooltip,
      splashRadius: 18,
    );
  }
}
