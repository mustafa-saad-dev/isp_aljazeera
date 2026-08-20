import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../core/routes/app_routes.dart';
import '../../views/dashboard/dashboard_shell.dart';
import '../../views/dashboard_home/dashboard_home_page.dart';
import '../../views/pages/placeholder_page.dart';
import '../../views/forget_password/forget_password_flow.dart';
import '../../views/auth/login_view.dart';
import '../../views/auth/register_view.dart';
import '../../views/splash/splash_view.dart';
import '../../views/users/users_view.dart';

class _AuthNotifier extends ChangeNotifier {
  _AuthNotifier(AuthController controller) {
    controller.stream.listen((_) => notifyListeners());
  }
}

final _authNotifier = _AuthNotifier(AuthController.instance);

final GoRouter appRouter = GoRouter(
  initialLocation: kIsWeb ? AppRoutes.login : AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const LoginView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final fade = Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).chain(CurveTween(curve: Curves.easeOut));
          final slide = Tween<Offset>(
            begin: const Offset(0.0, 0.15),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic));
          return FadeTransition(
            opacity: animation.drive(fade),
            child: SlideTransition(
              position: animation.drive(slide),
              child: child,
            ),
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.register,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const RegisterView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(
            begin: const Offset(0.3, 0.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic));
          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.forgetPassword,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ForgetPasswordFlow(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(
            begin: const Offset(0.3, 0.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic));
          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    ),
    ShellRoute(
      builder: (context, state, child) => DashboardShell(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const DashboardHomePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final fade = Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ).chain(CurveTween(curve: Curves.easeOut));
                  final scale = Tween<double>(
                    begin: 0.95,
                    end: 1.0,
                  ).chain(CurveTween(curve: Curves.easeOutCubic));
                  return FadeTransition(
                    opacity: animation.drive(fade),
                    child: ScaleTransition(
                      scale: animation.drive(scale),
                      child: child,
                    ),
                  );
                },
          ),
        ),
        GoRoute(
          path: AppRoutes.companies,
          builder: (context, state) => const PlaceholderPage(title: 'الشركات'),
        ),
        GoRoute(
          path: AppRoutes.users,
          builder: (context, state) => const UsersView(),
        ),
        GoRoute(
          path: AppRoutes.sales,
          builder: (context, state) => const PlaceholderPage(title: 'الفواتير'),
        ),
        GoRoute(
          path: AppRoutes.cashbox,
          builder: (context, state) => const PlaceholderPage(title: 'الحسابات'),
        ),
        GoRoute(
          path: AppRoutes.tickets,
          builder: (context, state) => const PlaceholderPage(title: 'التذاكر'),
        ),
        GoRoute(
          path: AppRoutes.tasks,
          builder: (context, state) => const PlaceholderPage(title: 'المهام'),
        ),
        GoRoute(
          path: AppRoutes.networkMap,
          builder: (context, state) =>
              const PlaceholderPage(title: 'خريطة الشبكة'),
        ),
        GoRoute(
          path: AppRoutes.networkMonitor,
          builder: (context, state) =>
              const PlaceholderPage(title: 'مراقبة الشبكة'),
        ),
        GoRoute(
          path: AppRoutes.reports,
          builder: (context, state) => const PlaceholderPage(title: 'التقارير'),
        ),
        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) =>
              const PlaceholderPage(title: 'الإعدادات'),
        ),
        GoRoute(
          path: AppRoutes.notifications,
          builder: (context, state) =>
              const PlaceholderPage(title: 'الإشعارات'),
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) =>
              const PlaceholderPage(title: 'الملف الشخصي'),
        ),
      ],
    ),
  ],
  redirect: (_, state) {
    final authState = AuthController.instance.state;
    final loggedIn = authState.isLoggedIn;
    final loc = state.matchedLocation;

    final onPublic =
        loc == AppRoutes.login ||
        loc == AppRoutes.register ||
        loc == AppRoutes.forgetPassword ||
        loc == AppRoutes.splash;

    if (kIsWeb) {
      if (loc == AppRoutes.splash) {
        return loggedIn ? AppRoutes.home : AppRoutes.login;
      }
      if (loggedIn) {
        return loc == AppRoutes.login ? AppRoutes.home : null;
      }
      return onPublic ? null : AppRoutes.login;
    }

    if (loggedIn &&
        (loc == AppRoutes.login ||
            loc == AppRoutes.register ||
            loc == AppRoutes.forgetPassword ||
            loc == AppRoutes.splash)) {
      return AppRoutes.home;
    }
    if (!loggedIn && !onPublic) return AppRoutes.splash;
    return null;
  },
  refreshListenable: _authNotifier,
);
