import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/app_routes.dart';
import 'widget_url_parser.dart';

class WidgetUrlMapper {
  WidgetUrlMapper._();

  static final Map<String, String> _pathToRoute = {
    '/users': AppRoutes.users,
    '/user': AppRoutes.users,
    '/index/user': AppRoutes.users,
    '/index/online': AppRoutes.users,
    '/billing': AppRoutes.sales,
    '/invoices': AppRoutes.sales,
    '/cashbox': AppRoutes.cashbox,
    '/accounts': AppRoutes.cashbox,
    '/tickets': AppRoutes.tickets,
    '/tasks': AppRoutes.tasks,
    '/network': AppRoutes.networkMap,
    '/devices': AppRoutes.networkMap,
    '/reports': AppRoutes.reports,
    '/log': AppRoutes.reports,
    '/settings': AppRoutes.settings,
    '/managers': AppRoutes.users,
    '/dashboard': AppRoutes.home,
  };

  static void navigate(BuildContext context, String? url) {
    final info = WidgetUrlParser.parse(url);
    if (info == null) return;

    final route = _resolveRoute(info.route);

    if (route == null) {
      debugPrint('[WidgetUrlMapper] No route for: ${info.route}');
      return;
    }

    if (info.hasFilter) {
      context.go(route, extra: info);
    } else {
      context.go(route);
    }
  }

  static String? _resolveRoute(String apiPath) {
    final segments = apiPath.split('/').where((s) => s.isNotEmpty).toList();
    if (segments.isEmpty) return null;

    final section = '/${segments.first}';

    return _pathToRoute[section];
  }
}
