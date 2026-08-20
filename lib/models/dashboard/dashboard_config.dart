import 'dashboard_widget_model.dart';

class DashboardRowModel {
  final String rowId;
  final int rowOrder;
  final List<DashboardWidgetModel> widgets;

  const DashboardRowModel({
    required this.rowId,
    required this.rowOrder,
    required this.widgets,
  });

  factory DashboardRowModel.fromJson(Map<String, dynamic> json) {
    return DashboardRowModel(
      rowId: json['row_id'] ?? '',
      rowOrder: json['row_order'] ?? 0,
      widgets: (json['widgets'] as List<dynamic>? ?? [])
          .map((w) => DashboardWidgetModel.fromJson(w as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DashboardAlertModel {
  final bool enabled;
  final String? type;
  final String? text;

  const DashboardAlertModel({
    required this.enabled,
    this.type,
    this.text,
  });

  factory DashboardAlertModel.fromJson(Map<String, dynamic> json) {
    return DashboardAlertModel(
      enabled: json['enabled'] ?? false,
      type: json['type'],
      text: json['text'],
    );
  }
}

class DashboardConfig {
  final List<DashboardRowModel> rows;
  final DashboardAlertModel alert;
  final int id;

  const DashboardConfig({
    required this.rows,
    required this.alert,
    required this.id,
  });

  factory DashboardConfig.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic> ? json['data'] : json;
    return DashboardConfig(
      rows: (data['widgets'] as List<dynamic>? ?? [])
          .map((r) => DashboardRowModel.fromJson(r as Map<String, dynamic>))
          .toList(),
      alert: data['alert'] is Map<String, dynamic>
          ? DashboardAlertModel.fromJson(data['alert'])
          : const DashboardAlertModel(enabled: false),
      id: data['id'] ?? 0,
    );
  }

  List<DashboardWidgetModel> get allWidgets =>
      rows.expand((r) => r.widgets).toList();
}
