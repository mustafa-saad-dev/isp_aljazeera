import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_translations.dart';
import '../../../core/routes/app_routes.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  static const _w = 240.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final loc = GoRouterState.of(context).matchedLocation;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Container(
      width: _w,
      color: scheme.secondary,
      child: Column(
        children: [
          // ── Logo ──
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
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
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.white.withValues(alpha: 0.08)),
          const SizedBox(height: 8),

          // ── Nav items ──
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                _NavItem(
                  icon: Icons.dashboard_outlined,
                  label: AppTranslations.tr('dashboard'),
                  route: AppRoutes.home,
                  currentRoute: loc,
                  isRtl: isRtl,
                ),
                _NavItem(
                  icon: Icons.business_outlined,
                  label: AppTranslations.tr('companies'),
                  route: AppRoutes.companies,
                  currentRoute: loc,
                  isRtl: isRtl,
                ),
                _NavItem(
                  icon: Icons.people_alt_outlined,
                  label: AppTranslations.tr('subscriptions'),
                  route: AppRoutes.subscriptions,
                  currentRoute: loc,
                  isRtl: isRtl,
                ),
                _NavItem(
                  icon: Icons.bar_chart_outlined,
                  label: AppTranslations.tr('reports'),
                  route: AppRoutes.reports,
                  currentRoute: loc,
                  isRtl: isRtl,
                ),
                _NavItem(
                  icon: Icons.notifications_outlined,
                  label: AppTranslations.tr('notifications'),
                  route: AppRoutes.notifications,
                  currentRoute: loc,
                  isRtl: isRtl,
                ),
                const SizedBox(height: 8),
                Divider(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
                const SizedBox(height: 8),
                _NavItem(
                  icon: Icons.settings_outlined,
                  label: AppTranslations.tr('settings'),
                  route: AppRoutes.settings,
                  currentRoute: loc,
                  isRtl: isRtl,
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  label: AppTranslations.tr('profile'),
                  route: AppRoutes.profile,
                  currentRoute: loc,
                  isRtl: isRtl,
                ),
              ],
            ),
          ),

          // ── Logout ──
          Divider(
            height: 1,
            color: Colors.white.withValues(alpha: 0.08),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              dense: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
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
                // TODO: logout via AuthController
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.currentRoute,
    required this.isRtl,
  });

  final IconData icon;
  final String label;
  final String route;
  final String currentRoute;
  final bool isRtl;

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
          onTap: active ? null : () => context.go(route),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: active
                  ? Border(
                      right: isRtl
                          ? BorderSide.none
                          : BorderSide(color: scheme.primary, width: 3),
                      left: isRtl
                          ? BorderSide(color: scheme.primary, width: 3)
                          : BorderSide.none,
                    )
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: active
                      ? scheme.primary
                      : const Color(0xff9aa0aa),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      color: active
                          ? Colors.white
                          : const Color(0xff9aa0aa),
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
