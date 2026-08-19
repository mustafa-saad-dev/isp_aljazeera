import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/app_translations.dart';
import '../../../../core/routes/app_routes.dart';
import 'sidebar_header.dart';
import 'sidebar_item.dart';
import 'sidebar_dropdown.dart';
import 'sidebar_sub_item.dart';
import 'sidebar_nested_dropdown.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key, this.collapsed = false, this.onToggle});

  final bool collapsed;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).matchedLocation;
    final scheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: scheme.secondary,
      child: Column(
        children: [
          SidebarHeader(collapsed: collapsed),
          const SizedBox(height: 4),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 4),
              children: [
                // ── لوحة التحكم ─────────────────────────────────
                SidebarItem(
                  icon: Icons.dashboard_outlined,
                  label: AppTranslations.tr('dashboard'),
                  active: loc == AppRoutes.home,
                  onTap: () => context.go(AppRoutes.home),
                  collapsed: collapsed,
                ),

                // ── الشركات (dropdown) ──────────────────────────
                SidebarDropdown(
                  icon: Icons.business_outlined,
                  label: AppTranslations.tr('companies'),
                  active: loc == AppRoutes.companies,
                  collapsed: collapsed,
                  children: [
                    SidebarSubItem(
                      label: 'كل الشركات',
                      active: loc == AppRoutes.companies,
                      onTap: () => context.go(AppRoutes.companies),
                    ),
                    SidebarSubItem(label: 'إضافة شركة', onTap: () {}),
                    SidebarSubItem(label: 'تصدير', onTap: () {}),
                  ],
                ),

                // ── المشتركين ───────────────────────────────────
                SidebarItem(
                  icon: Icons.people_alt_outlined,
                  label: AppTranslations.tr('subscribers'),
                  active: loc == AppRoutes.subscriptions,
                  onTap: () => context.go(AppRoutes.subscriptions),
                  collapsed: collapsed,
                ),

                // ── الفواتير (dropdown → nested dropdown) ───────
                SidebarDropdown(
                  icon: Icons.receipt_long_outlined,
                  label: AppTranslations.tr('sales'),
                  active: loc == '/sales',
                  collapsed: collapsed,
                  children: [
                    SidebarSubItem(label: 'كل الفواتير', onTap: () {}),
                    SidebarSubItem(label: 'إضافة فاتورة', onTap: () {}),

                    // ── nested dropdown inside الفواتير ──────────
                    SidebarNestedDropdown(
                      label: 'أنواع الفواتير',
                      collapsed: collapsed,
                      children: [
                        SidebarSubItem(label: 'اشتراك شهري', onTap: () {}),
                        SidebarSubItem(label: 'اشتراك سنوي', onTap: () {}),
                        SidebarSubItem(label: 'ơست succeeds', onTap: () {}),
                      ],
                    ),

                    SidebarSubItem(label: 'تصدير', onTap: () {}),
                  ],
                ),

                // ── الحسابات (dropdown) ─────────────────────────
                SidebarDropdown(
                  icon: Icons.account_balance_wallet_outlined,
                  label: AppTranslations.tr('cashbox'),
                  active: loc == '/cashbox',
                  collapsed: collapsed,
                  children: [
                    SidebarSubItem(label: 'سجل الحسابات', onTap: () {}),
                    SidebarSubItem(label: 'إضافة حساب', onTap: () {}),

                    // ── nested dropdown inside الحسابات ──────────
                    SidebarNestedDropdown(
                      label: 'أنواع الحسابات',
                      collapsed: collapsed,
                      children: [
                        SidebarSubItem(label: 'نقد', onTap: () {}),
                        SidebarSubItem(label: 'تحويل بنكي', onTap: () {}),
                        SidebarSubItem(label: 'شيك', onTap: () {}),
                      ],
                    ),

                    SidebarSubItem(label: 'تقرير يومي', onTap: () {}),
                  ],
                ),

                // ── التذاكر ──────────────────────────────────────
                SidebarItem(
                  icon: Icons.confirmation_num_outlined,
                  label: AppTranslations.tr('tickets'),
                  active: loc == '/tickets',
                  onTap: () {},
                  collapsed: collapsed,
                ),

                // ── المهام ──────────────────────────────────────
                SidebarItem(
                  icon: Icons.task_alt_outlined,
                  label: AppTranslations.tr('tasks'),
                  active: loc == '/tasks',
                  onTap: () {},
                  collapsed: collapsed,
                ),

                // ── خريطة الشبكة ────────────────────────────────
                SidebarItem(
                  icon: Icons.map_outlined,
                  label: AppTranslations.tr('networkMap'),
                  active: loc == '/network-map',
                  onTap: () {},
                  collapsed: collapsed,
                ),

                // ── مراقبة الشبكة ───────────────────────────────
                SidebarItem(
                  icon: Icons.monitor_heart_outlined,
                  label: AppTranslations.tr('networkMonitor'),
                  active: loc == '/network-monitor',
                  onTap: () {},
                  collapsed: collapsed,
                ),

                // ── الإعدادات (dropdown) ────────────────────────
                SidebarDropdown(
                  icon: Icons.settings_outlined,
                  label: AppTranslations.tr('settings'),
                  active: loc == AppRoutes.settings,
                  collapsed: collapsed,
                  children: [
                    SidebarSubItem(label: 'عام', onTap: () {}),
                    SidebarSubItem(label: 'المظهر', onTap: () {}),
                    SidebarSubItem(label: 'الإشعارات', onTap: () {}),

                    // ── nested dropdown inside الإعدادات ──────────
                    SidebarNestedDropdown(
                      label: 'إدارة المستخدمين',
                      collapsed: collapsed,
                      children: [
                        SidebarSubItem(label: 'المستخدمين', onTap: () {}),
                        SidebarSubItem(label: 'الصلاحيات', onTap: () {}),
                        SidebarSubItem(label: 'أدوار الوصول', onTap: () {}),
                      ],
                    ),

                    SidebarSubItem(label: 'النسخ الاحتياطي', onTap: () {}),
                  ],
                ),
              ],
            ),
          ),

          // ── profile + logout ──────────────────────────────────
          Divider(height: 1, color: Colors.white.withValues(alpha: 0.08)),
          SidebarItem(
            icon: Icons.person_outline,
            label: AppTranslations.tr('profile'),
            active: loc == AppRoutes.profile,
            onTap: () => context.go(AppRoutes.profile),
            collapsed: collapsed,
          ),
          SidebarItem(
            icon: Icons.logout_outlined,
            label: AppTranslations.tr('logout'),
            active: false,
            onTap: () {},
            collapsed: collapsed,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
