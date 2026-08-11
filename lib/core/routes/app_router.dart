import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

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
