import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/dashboard/dashboard_controller.dart';
import '../../../core/navigation/nav_config.dart';
import '../../../core/navigation/nav_item.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/sidebar/sidebar_dropdown.dart';
import '../../widgets/sidebar/sidebar_header.dart';
import '../../widgets/sidebar/sidebar_item.dart';
import '../../widgets/sidebar/sidebar_nested_dropdown.dart';
import '../../widgets/sidebar/sidebar_sub_item.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).matchedLocation;
    final scheme = context.colorScheme;
    final permissions =
        context.watch<DashboardController>().state.permissions;
    final api1Permissions =
        context.watch<DashboardController>().state.api1Permissions;
    final items = NavConfig.items(loc)
        .where((item) => item.isAllowed(permissions, api1Permissions))
        .toList();

    return Drawer(
      shape: const RoundedRectangleBorder(),
      backgroundColor: scheme.secondary,
      child: SafeArea(
        child: Column(
          children: [
            const SidebarHeader(),
            Divider(height: 1, color: scheme.onSecondary.withValues(alpha: 0.08)),
            const SizedBox(height: 4),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.symmetric(vertical: 4),
                itemBuilder: (context, index) =>
                    _buildItem(context, items[index], loc, permissions, api1Permissions),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    NavItem item,
    String loc,
    List<String> permissions,
    List<String> api1Permissions,
  ) {
    final allowedChildren = item.allowedChildren(permissions, api1Permissions);

    if (allowedChildren.isEmpty) {
      return SidebarItem(
        icon: item.icon!,
        label: item.label,
        active: item.isActive(loc),
        onTap: () {
          Navigator.pop(context);
          if (item.onTap != null) {
            item.onTap!();
            return;
          }
          if (item.route != null) context.go(item.route!);
        },
      );
    }

    return SidebarDropdown(
      icon: item.icon!,
      label: item.label,
      active: item.isActive(loc),
      children: allowedChildren.map((child) {
        if (child.children.isNotEmpty) {
          return SidebarNestedDropdown(
            label: child.label,
            children: child.allowedChildren(permissions, api1Permissions).map((nested) {
              return SidebarSubItem(
                label: nested.label,
                active: nested.isActive(loc),
                onTap: nested.route != null
                    ? () {
                        Navigator.pop(context);
                        context.go(nested.route!);
                      }
                    : null,
              );
            }).toList(),
          );
        }
        return SidebarSubItem(
          label: child.label,
          active: child.isActive(loc),
          onTap: child.route != null
              ? () {
                  Navigator.pop(context);
                  context.go(child.route!);
                }
              : null,
        );
      }).toList(),
    );
  }
}
