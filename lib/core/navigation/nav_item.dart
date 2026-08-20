import 'package:flutter/material.dart';

enum NavType { item, dropdown, button, divider }

class NavItem {
  final NavType type;
  final IconData? icon;
  final String label;
  final String? route;
  final VoidCallback? onTap;
  final String? acl;
  final String? api1Acl;
  final List<NavItem> children;

  const NavItem({
    this.type = NavType.item,
    this.icon,
    required this.label,
    this.route,
    this.onTap,
    this.acl,
    this.api1Acl,
    this.children = const [],
  });

  bool isActive(String currentLoc) {
    if (route != null) return currentLoc == route;
    return children.any((c) => c.isActive(currentLoc));
  }

  bool _checkAcl(String? rule, List<String> permissions) {
    if (rule == null || rule.isEmpty || rule == 'any') return true;
    final required = rule.split('|').map((s) => s.trim()).toList();
    return required.any((p) => permissions.contains(p));
  }

  bool isAllowed(List<String> api2Permissions, List<String> api1Permissions) {
    final api2Ok = _checkAcl(acl, api2Permissions);
    final api1Ok = _checkAcl(api1Acl, api1Permissions);
    if (acl != null && api1Acl != null) return api2Ok && api1Ok;
    if (acl != null) return api2Ok;
    if (api1Acl != null) return api1Ok;
    return true;
  }

  List<NavItem> allowedChildren(
    List<String> api2Permissions,
    List<String> api1Permissions,
  ) {
    return children
        .where((c) => c.isAllowed(api2Permissions, api1Permissions))
        .toList();
  }
}
