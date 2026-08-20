class WidgetUrlInfo {
  final String route;
  final Map<String, String> params;

  const WidgetUrlInfo({required this.route, this.params = const {}});

  bool get hasFilter => params.containsKey('filter');
  String? get filter => params['filter'];
}

class WidgetUrlParser {
  WidgetUrlParser._();

  static WidgetUrlInfo? parse(String? url) {
    if (url == null || url.isEmpty) return null;

    var cleaned = url.trim();

    cleaned = cleaned.replaceFirst(RegExp(r'^\.?/?#/?'), '/');

    if (!cleaned.startsWith('/')) cleaned = '/$cleaned';

    final uri = Uri.parse(cleaned);
    final path = uri.path.isEmpty ? '/' : uri.path;
    final params = <String, String>{};

    uri.queryParameters.forEach((key, value) {
      params[key] = Uri.decodeComponent(value);
    });

    return WidgetUrlInfo(route: path, params: params);
  }
}
