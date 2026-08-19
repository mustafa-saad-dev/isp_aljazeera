import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:isp_aljazeera/controllers/auth/auth_controller.dart';
import 'package:isp_aljazeera/core/localization/app_translations.dart';
import 'package:isp_aljazeera/core/routes/app_routes.dart';
import 'package:isp_aljazeera/views/home/widgets/space_tile.dart';
import 'package:isp_aljazeera/widgets/common/double_back_to_exit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = context.select<AuthController, UserModel?>(
    //   (c) => c.state.user,
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppTranslations.tr('appName')),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
          IconButton(
            onPressed: () => context.read<AuthController>().logout(),
            icon: const Icon(Icons.logout_outlined),
            tooltip: AppTranslations.tr('logout'),
          ),
        ],
      ),
      body: DoubleBackToExit(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     gradient: const LinearGradient(
            //       colors: [AppBrand.brand, AppBrand.accent],
            //     ),
            //     borderRadius: BorderRadius.circular(18),
            //   ),
            //   child: Row(
            //     children: [
            //       CircleAvatar(
            //         radius: 26,
            //         backgroundColor: Colors.white.withValues(alpha: 0.25),
            //         child: Text(
            //           (user?.name.isNotEmpty == true ? user!.name[0] : 'U')
            //               .toUpperCase(),
            //           style: const TextStyle(
            //             color: Colors.white,
            //             fontSize: 24,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ),
            //       const SizedBox(width: 14),
            //       Expanded(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               '${AppTranslations.tr('welcome')}${user?.name ?? ''}',
            //               style: const TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 18,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //             const SizedBox(height: 4),
            //             Text(
            //               user?.role ?? '',
            //               style: const TextStyle(
            //                 color: Colors.white70,
            //                 fontSize: 13,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 18),
            Text(
              AppTranslations.tr('workspaces'),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                SpaceTile(
                  title: AppTranslations.tr('clients'),
                  icon: Icons.people_alt_outlined,
                  count: '1,248',
                ),
                SpaceTile(
                  title: AppTranslations.tr('orders'),
                  icon: Icons.receipt_long_outlined,
                  count: '312',
                ),
                SpaceTile(
                  title: AppTranslations.tr('invoices'),
                  icon: Icons.receipt_outlined,
                  count: '87',
                ),
                SpaceTile(
                  title: AppTranslations.tr('support'),
                  icon: Icons.support_agent_outlined,
                  count: '23',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              AppTranslations.tr('reports'),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.bar_chart_outlined),
                title: Text(AppTranslations.tr('monthlyPerf')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutes.reports),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.pie_chart_outline),
                title: Text(AppTranslations.tr('revenueReport')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutes.reports),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppTranslations.tr('settings'),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: Text(AppTranslations.tr('accountSettings')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutes.settings),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
