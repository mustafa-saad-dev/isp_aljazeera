import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_translations.dart';
import '../../../core/routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final loc = GoRouterState.of(context).matchedLocation;

    return Drawer(
      backgroundColor: scheme.secondary,
      child: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.wifi, color: scheme.primary, size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      AppTranslations.tr('appName'),
                      style: TextStyle(
                        color: scheme.onSecondary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: scheme.onSecondary.withValues(alpha: 0.6),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Colors.white.withValues(alpha: 0.08),
            ),
            const SizedBox(height: 8),

            // ── Nav items ──
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  _DrawerItem(
                    icon: Icons.dashboard_outlined,
                    label: AppTranslations.tr('dashboard'),
                    route: AppRoutes.home,
                    currentRoute: loc,
                    onTap: (route) {
                      Navigator.pop(context);
                      context.go(route);
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.business_outlined,
                    label: AppTranslations.tr('companies'),
                    route: AppRoutes.companies,
                    currentRoute: loc,
                    onTap: (route) {
                      Navigator.pop(context);
                      context.go(route);
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.people_alt_outlined,
                    label: AppTranslations.tr('subscriptions'),
                    route: AppRoutes.subscriptions,
                    currentRoute: loc,
                    onTap: (route) {
                      Navigator.pop(context);
                      context.go(route);
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.bar_chart_outlined,
                    label: AppTranslations.tr('reports'),
                    route: AppRoutes.reports,
                    currentRoute: loc,
                    onTap: (route) {
                      Navigator.pop(context);
                      context.go(route);
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.notifications_outlined,
                    label: AppTranslations.tr('notifications'),
                    route: AppRoutes.notifications,
                    currentRoute: loc,
                    onTap: (route) {
                      Navigator.pop(context);
                      context.go(route);
                    },
                  ),
                  const SizedBox(height: 8),
                  Divider(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                  const SizedBox(height: 8),
                  _DrawerItem(
                    icon: Icons.settings_outlined,
                    label: AppTranslations.tr('settings'),
                    route: AppRoutes.settings,
                    currentRoute: loc,
                    onTap: (route) {
                      Navigator.pop(context);
                      context.go(route);
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.person_outline,
                    label: AppTranslations.tr('profile'),
                    route: AppRoutes.profile,
                    currentRoute: loc,
                    onTap: (route) {
                      Navigator.pop(context);
                      context.go(route);
                    },
                  ),
                ],
              ),
            ),

            // ── Logout ──
            Divider(
              height: 1,
              color: Colors.white.withValues(alpha: 0.08),
            ),
            ListTile(
              dense: true,
              leading: const Icon(
                Icons.logout_outlined,
                color: Color(0xff9aa0aa),
                size: 20,
              ),
              title: Text(
                AppTranslations.tr('logout'),
                style: const TextStyle(
                  color: Color(0xff9aa0aa),
                  fontSize: 13,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: logout via AuthController
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.currentRoute,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String route;
  final String currentRoute;
  final void Function(String route) onTap;

  @override
  Widget build(BuildContext context) {
    final active = currentRoute == route;
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: active ? const Color(0xff2b2f36) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => onTap(route),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: active ? scheme.primary : const Color(0xff9aa0aa),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      color:
                          active ? Colors.white : const Color(0xff9aa0aa),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
