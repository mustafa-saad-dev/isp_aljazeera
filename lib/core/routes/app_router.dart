import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../core/routes/app_routes.dart';
import '../../views/forget_password/forget_password_flow.dart';
import '../../views/auth/login_view.dart';
import '../../views/auth/register_view.dart';
import '../../views/home/home_view.dart';
import '../../views/reports/reports_view.dart';
import '../../views/settings/settings_view.dart';
import '../../views/splash/splash_view.dart';

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
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: AppRoutes.register,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const RegisterView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(begin: const Offset(0.3, 0.0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeOutCubic));
          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
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
          final tween = Tween(begin: const Offset(0.3, 0.0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeOutCubic));
          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: AppRoutes.reports,
      builder: (context, state) => const ReportsView(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsView(),
    ),
  ],
  redirect: (_, state) {
    final authState = AuthController.instance.state;
    final loggedIn = authState.user != null;
    final loc = state.matchedLocation;

    final onPublic =
        loc == AppRoutes.login ||
        loc == AppRoutes.register ||
        loc == AppRoutes.forgetPassword ||
        loc == AppRoutes.splash;

    if (kIsWeb) {
      if (loggedIn) return loc == AppRoutes.home ? null : AppRoutes.home;
      if (onPublic) return null;
      return AppRoutes.login;
    }

    if (loggedIn && (loc == AppRoutes.login || loc == AppRoutes.register || loc == AppRoutes.forgetPassword)) {
      return AppRoutes.home;
    }
    if (!loggedIn && !onPublic) return AppRoutes.splash;
    return null;
  },
  refreshListenable: _authNotifier,
);
