import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/app_translations.dart';
import '../../../../core/routes/app_routes.dart';
import 'drawer_header.dart';
import '../drawer/drawer_item.dart';

const Color _kBg = Color(0xFF22262C);
const Color _kInactiveColor = Color(0xFF9AA0AA);

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).matchedLocation;

    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(0),
      ),
      backgroundColor: _kBg,
      child: SafeArea(
        child: Column(
          children: [
            const AppDrawerHeader(),
            Divider(height: 1, color: Colors.white.withValues(alpha: 0.08)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                children: [
                  DrawerItem(
                    icon: Icons.dashboard_outlined,
                    label: AppTranslations.tr('dashboard'),
                    active: loc == AppRoutes.home,
                    onTap: () {
                      Navigator.pop(context);
                      context.go(AppRoutes.home);
                    },
                  ),
                  DrawerItem(
                    icon: Icons.business_outlined,
                    label: AppTranslations.tr('companies'),
                    active: loc == AppRoutes.companies,
                    onTap: () {
                      Navigator.pop(context);
                      context.go(AppRoutes.companies);
                    },
                  ),
                  DrawerItem(
                    icon: Icons.people_alt_outlined,
                    label: AppTranslations.tr('subscribers'),
                    active: loc == AppRoutes.subscriptions,
                    onTap: () {
                      Navigator.pop(context);
                      context.go(AppRoutes.subscriptions);
                    },
                  ),
                  DrawerItem(
                    icon: Icons.receipt_long_outlined,
                    label: AppTranslations.tr('sales'),
                    active: loc == '/sales',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  DrawerItem(
                    icon: Icons.account_balance_wallet_outlined,
                    label: AppTranslations.tr('cashbox'),
                    active: loc == '/cashbox',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  DrawerItem(
                    icon: Icons.confirmation_num_outlined,
                    label: AppTranslations.tr('tickets'),
                    active: loc == '/tickets',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  DrawerItem(
                    icon: Icons.task_alt_outlined,
                    label: AppTranslations.tr('tasks'),
                    active: loc == '/tasks',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  DrawerItem(
                    icon: Icons.map_outlined,
                    label: AppTranslations.tr('networkMap'),
                    active: loc == '/network-map',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  DrawerItem(
                    icon: Icons.monitor_heart_outlined,
                    label: AppTranslations.tr('networkMonitor'),
                    active: loc == '/network-monitor',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  DrawerItem(
                    icon: Icons.settings_outlined,
                    label: AppTranslations.tr('settings'),
                    active: loc == AppRoutes.settings,
                    onTap: () {
                      Navigator.pop(context);
                      context.go(AppRoutes.settings);
                    },
                  ),
                  DrawerItem(
                    icon: Icons.person_outline,
                    label: AppTranslations.tr('profile'),
                    active: loc == AppRoutes.profile,
                    onTap: () {
                      Navigator.pop(context);
                      context.go(AppRoutes.profile);
                    },
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.white.withValues(alpha: 0.08)),
            ListTile(
              dense: true,
              leading: const Icon(
                Icons.logout_outlined,
                color: _kInactiveColor,
                size: 20,
              ),
              title: Text(
                AppTranslations.tr('logout'),
                style: const TextStyle(color: _kInactiveColor, fontSize: 13),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
