import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/dashboard/dashboard_controller.dart';
import '../../../core/navigation/nav_config.dart';
import '../../../core/navigation/nav_item.dart';
import '../../widgets/sidebar/sidebar_dropdown.dart';
import '../../widgets/sidebar/sidebar_header.dart';
import '../../widgets/sidebar/sidebar_item.dart';
import '../../widgets/sidebar/sidebar_nested_dropdown.dart';
import '../../widgets/sidebar/sidebar_sub_item.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key, this.collapsed = false, this.onToggle});

  final bool collapsed;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).matchedLocation;
    final scheme = Theme.of(context).colorScheme;
    final permissions =
        context.watch<DashboardController>().state.permissions;
    final api1Permissions =
        context.watch<DashboardController>().state.api1Permissions;
    final items = NavConfig.items(loc)
        .where((item) => item.isAllowed(permissions, api1Permissions))
        .toList();

    return ColoredBox(
      color: scheme.secondary,
      child: Column(
        children: [
          SidebarHeader(collapsed: collapsed),
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
          if (item.onTap != null) {
            item.onTap!();
            return;
          }
          if (item.route != null) context.go(item.route!);
        },
        collapsed: collapsed,
      );
    }

    return SidebarDropdown(
      icon: item.icon!,
      label: item.label,
      active: item.isActive(loc),
      collapsed: collapsed,
      children: allowedChildren.map((child) {
        if (child.children.isNotEmpty) {
          return SidebarNestedDropdown(
            label: child.label,
            collapsed: collapsed,
            children: child.allowedChildren(permissions, api1Permissions).map((nested) {
              return SidebarSubItem(
                label: nested.label,
                active: nested.isActive(loc),
                onTap: nested.route != null
                    ? () => context.go(nested.route!)
                    : null,
              );
            }).toList(),
          );
        }
        return SidebarSubItem(
          label: child.label,
          active: child.isActive(loc),
          onTap: child.route != null ? () => context.go(child.route!) : null,
        );
      }).toList(),
    );
  }
}
