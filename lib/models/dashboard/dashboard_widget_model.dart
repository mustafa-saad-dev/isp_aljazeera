class DashboardWidgetModel {
  final int id;
  final String name;
  final String type;
  final String? color;
  final String? width;
  final String? icon;
  final String? externalDataSource;
  final String? internalDataSource;
  final String dataSource;
  final String title;
  final int? interval;
  final String? description;
  final bool builtIn;
  final String? url;

  const DashboardWidgetModel({
    required this.id,
    required this.name,
    required this.type,
    this.color,
    this.width,
    this.icon,
    this.externalDataSource,
    this.internalDataSource,
    required this.dataSource,
    required this.title,
    this.interval,
    this.description,
    this.builtIn = false,
    this.url,
  });

  int get widthFlex => int.tryParse(width ?? '3') ?? 3;

  factory DashboardWidgetModel.fromJson(Map<String, dynamic> json) {
    return DashboardWidgetModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      color: json['color'],
      width: json['width'],
      icon: json['icon'],
      externalDataSource: json['external_data_source'],
      internalDataSource: json['internal_data_source'],
      dataSource: json['data_source'] ?? '',
      title: json['title'] ?? '',
      interval: json['interval'],
      description: json['description'],
      builtIn: json['built_in'] == true || json['built_in'] == 1,
      url: json['url'],
    );
  }
}
