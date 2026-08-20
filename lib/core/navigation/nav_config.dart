import 'package:flutter/material.dart';

import '../../core/localization/app_translations.dart';
import '../../core/routes/app_routes.dart';
import 'nav_item.dart';

abstract class NavConfig {
  NavConfig._();

  static String titleForLocation(String loc) {
    final items = NavConfig.items(loc);
    for (final item in items) {
      if (item.route == loc) return item.label;
      for (final child in item.children) {
        if (child.route == loc) return '${item.label} / ${child.label}';
      }
    }
    return AppTranslations.tr('dashboard');
  }

  static List<NavItem> items(String loc) => [
    NavItem(
      icon: Icons.dashboard_outlined,
      label: AppTranslations.tr('dashboard'),
      route: AppRoutes.home,
      acl: 'any',
    ),
    NavItem(
      icon: Icons.people_alt_outlined,
      label: AppTranslations.tr('users'),
      route: AppRoutes.users,
      acl: 'prm_users_index',
    ),
    NavItem(
      icon: Icons.business_outlined,
      label: AppTranslations.tr('companies'),
      route: AppRoutes.companies,
      acl: 'prm_managers_index',
    ),
    NavItem(
      icon: Icons.receipt_long_outlined,
      label: AppTranslations.tr('billing'),
      route: AppRoutes.sales,
      acl: 'prm_billing',
    ),
    NavItem(
      icon: Icons.wifi_outlined,
      label: AppTranslations.tr('hotspot'),
      route: AppRoutes.sales,
      acl: 'prm_hotspot',
    ),
    NavItem(
      icon: Icons.link_outlined,
      label: AppTranslations.tr('pppoe'),
      route: AppRoutes.sales,
      acl: 'prm_pppoe',
    ),
    NavItem(
      icon: Icons.cell_tower_outlined,
      label: AppTranslations.tr('devices'),
      route: AppRoutes.networkMap,
      acl: 'prm_devices_index',
    ),
    NavItem(
      icon: Icons.map_outlined,
      label: AppTranslations.tr('network'),
      route: AppRoutes.networkMap,
      acl: 'any',
    ),
    NavItem(
      icon: Icons.confirmation_num_outlined,
      label: AppTranslations.tr('tickets'),
      route: AppRoutes.tickets,
      acl: 'prm_tickets_index',
    ),
    NavItem(
      icon: Icons.task_alt_outlined,
      label: AppTranslations.tr('tasks'),
      route: AppRoutes.tasks,
      acl: 'prm_tasks_index',
    ),
    NavItem(
      icon: Icons.account_balance_wallet_outlined,
      label: AppTranslations.tr('cashbox'),
      route: AppRoutes.cashbox,
      acl: 'prm_cashbox',
    ),
    NavItem(
      icon: Icons.support_agent_outlined,
      label: AppTranslations.tr('support'),
      route: AppRoutes.tickets,
      acl: 'prm_support_tickets_index',
    ),
    NavItem(
      icon: Icons.monitor_heart_outlined,
      label: AppTranslations.tr('monitor'),
      route: AppRoutes.networkMonitor,
      acl: 'any',
    ),
    NavItem(
      icon: Icons.notifications_outlined,
      label: AppTranslations.tr('notifications'),
      route: AppRoutes.notifications,
      acl: 'any',
    ),
    NavItem(
      icon: Icons.assessment_outlined,
      label: AppTranslations.tr('reports'),
      route: AppRoutes.reports,
      acl: 'prm_report_activate|prm_billing|prm_users_system_status|prm_logs',
    ),
    NavItem(
      icon: Icons.settings_outlined,
      label: AppTranslations.tr('settings'),
      route: AppRoutes.settings,
      acl: 'any',
    ),
  ];
}
