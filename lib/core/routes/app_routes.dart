import 'app_routes_name.dart';

abstract class AppRoutes {
  AppRoutes._();

  static const splash = '/${AppRoutesName.splash}';
  static const login = '/${AppRoutesName.login}';
  static const register = '/${AppRoutesName.register}';
  static const forgetPassword = '/${AppRoutesName.forgetPassword}';
  static const home = '/${AppRoutesName.home}';
  static const companies = '/${AppRoutesName.companies}';
  static const subscriptions = '/${AppRoutesName.subscriptions}';
  static const reports = '/${AppRoutesName.reports}';
  static const settings = '/${AppRoutesName.settings}';
  static const notifications = '/${AppRoutesName.notifications}';
  static const profile = '/${AppRoutesName.profile}';
}
