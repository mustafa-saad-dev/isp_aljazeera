import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../../views/splash/splash_view.dart';
import '../../views/auth/login_view.dart';
import '../../views/auth/register_view.dart';
import '../../views/auth/pending_approval_view.dart';
import '../../views/root/root_view.dart';
import '../../views/accounts/accounts_view.dart';
import '../../views/accounts/add_edit_account_view.dart';
import '../../views/home/home_view.dart';
import '../../views/subscribers/subscribers_view.dart';
import '../../views/subscriber_details/subscriber_details_view.dart';
import '../../views/edit_subscriber/edit_subscriber_view.dart';
import '../../views/activation/activation_view.dart';
import '../../views/managers/managers_view.dart';
import '../../views/managers/manager_details_view.dart';
import '../../views/managers/settlement_view.dart';
import '../../views/debts/debts_view.dart';
import '../../views/reports/reports_view.dart';
import '../../views/campaigns/campaigns_view.dart';
import '../../views/campaigns/campaign_details_view.dart';
import '../../views/settings/settings_view.dart';
import '../../views/page_not_found/page_not_found.dart';
import 'app_routes_name.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  routes: [
    // GoRoute(
    //   path: AppRoutes.splash,
    //   name: AppRouteNames.splash,
    //   builder: (context, state) => const SplashView(),
    // ),
    // GoRoute(
    //   path: AppRoutes.login,
    //   name: AppRouteNames.login,
    //   builder: (context, state) => const LoginView(),
    // ),
    // GoRoute(
    //   path: AppRoutes.register,
    //   name: AppRouteNames.register,
    //   builder: (context, state) => const RegisterView(),
    // ),
    // GoRoute(
    //   path: AppRoutes.pendingApproval,
    //   name: AppRouteNames.pendingApproval,
    //   builder: (context, state) => const PendingApprovalView(),
    // ),

    // Adaptive shell: bottom nav bar (compact), nav rail (medium/expanded —
    // tablet, Windows, web). Same route tree drives every platform; only the
    // chrome around it adapts, per the breakpoint rules in the build plan.
    // ShellRoute(
    //   navigatorKey: shellNavigatorKey,
    //   builder: (context, state, child) => RootView(child: child),
    //   routes: [
    //     GoRoute(
    //       path: AppRoutes.home,
    //       name: AppRouteNames.home,
    //       builder: (context, state) => const HomeView(),
    //     ),
    //     GoRoute(
    //       path: AppRoutes.accounts,
    //       name: AppRouteNames.accounts,
    //       builder: (context, state) => const AccountsView(),
    //       routes: [
    //         GoRoute(
    //           path: 'add',
    //           name: AppRouteNames.addEditAccount,
    //           builder: (context, state) {
    //             // existing account passed via `extra` for edit mode, null for add
    //             final account = state.extra;
    //             return AddEditAccountView(existing: account);
    //           },
    //         ),
    //       ],
    //     ),
    //     GoRoute(
    //       path: AppRoutes.subscribers,
    //       name: AppRouteNames.subscribers,
    //       builder: (context, state) => const SubscribersView(),
    //       routes: [
    //         GoRoute(
    //           path: ':id',
    //           name: AppRouteNames.subscriberDetails,
    //           parentNavigatorKey:
    //               rootNavigatorKey, // full screen, above the shell
    //           builder: (context, state) {
    //             final id = int.parse(state.pathParameters['id']!);
    //             return SubscriberDetailsView(subscriberId: id);
    //           },
    //           routes: [
    //             GoRoute(
    //               path: 'edit',
    //               name: AppRouteNames.editSubscriber,
    //               parentNavigatorKey: rootNavigatorKey,
    //               builder: (context, state) {
    //                 final id = int.parse(state.pathParameters['id']!);
    //                 return EditSubscriberView(subscriberId: id);
    //               },
    //             ),
    //             GoRoute(
    //               path: 'activate',
    //               name: AppRouteNames.activation,
    //               parentNavigatorKey: rootNavigatorKey,
    //               builder: (context, state) {
    //                 final id = int.parse(state.pathParameters['id']!);
    //                 return ActivationView(subscriberId: id);
    //               },
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //     GoRoute(
    //       path: AppRoutes.managers,
    //       name: AppRouteNames.managers,
    //       builder: (context, state) => const ManagersView(),
    //       routes: [
    //         GoRoute(
    //           path: ':id',
    //           name: AppRouteNames.managerDetails,
    //           parentNavigatorKey: rootNavigatorKey,
    //           builder: (context, state) {
    //             final id = int.parse(state.pathParameters['id']!);
    //             return ManagerDetailsView(managerId: id);
    //           },
    //         ),
    //         GoRoute(
    //           path: 'settlement',
    //           name: AppRouteNames.settlement,
    //           parentNavigatorKey: rootNavigatorKey,
    //           builder: (context, state) => const SettlementView(),
    //         ),
    //       ],
    //     ),
    //     GoRoute(
    //       path: AppRoutes.debts,
    //       name: AppRouteNames.debts,
    //       builder: (context, state) => const DebtsView(),
    //     ),
    //     GoRoute(
    //       path: AppRoutes.reports,
    //       name: AppRouteNames.reports,
    //       builder: (context, state) => const ReportsView(),
    //     ),
    //     GoRoute(
    //       path: AppRoutes.campaigns,
    //       name: AppRouteNames.campaigns,
    //       builder: (context, state) => const CampaignsView(),
    //       routes: [
    //         GoRoute(
    //           path: ':id',
    //           name: AppRouteNames.campaignDetails,
    //           parentNavigatorKey: rootNavigatorKey,
    //           builder: (context, state) {
    //             final id = int.parse(state.pathParameters['id']!);
    //             return CampaignDetailsView(campaignId: id);
    //           },
    //         ),
    //       ],
    //     ),
    //     GoRoute(
    //       path: AppRoutes.settings,
    //       name: AppRouteNames.settings,
    //       builder: (context, state) => const SettingsView(),
    //     ),
    //   ],
    // ),
  
  ],
  // errorBuilder: (context, state) => const PageNotFound(),
);
