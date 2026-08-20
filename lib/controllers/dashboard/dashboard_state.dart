import 'package:equatable/equatable.dart';

import '../../core/status/request_status.dart';
import '../../models/dashboard/api_client.dart';
import '../../models/dashboard/dashboard_company.dart';

class DashboardState extends Equatable {
  final RequestStatus status;
  final List<DashboardCompany> companies;
  final DashboardCompany? selectedCompany;
  final ApiClient? client;
  final List<String> permissions;
  final List<String> api1Permissions;
  final List<String> features;
  final String? message;
  final bool isSubmitting;

  const DashboardState({
    this.status = RequestStatus.initial,
    this.companies = const [],
    this.selectedCompany,
    this.client,
    this.permissions = const [],
    this.api1Permissions = const [],
    this.features = const [],
    this.message,
    this.isSubmitting = false,
  });

  DashboardState copyWith({
    RequestStatus? status,
    List<DashboardCompany>? companies,
    DashboardCompany? selectedCompany,
    ApiClient? client,
    List<String>? permissions,
    List<String>? api1Permissions,
    List<String>? features,
    String? message,
    bool clearSelected = false,
    bool clearClient = false,
    bool clearMessage = false,
    bool? isSubmitting,
  }) {
    return DashboardState(
      status: status ?? this.status,
      companies: companies ?? this.companies,
      selectedCompany: clearSelected
          ? null
          : (selectedCompany ?? this.selectedCompany),
      client: clearClient ? null : (client ?? this.client),
      permissions: permissions ?? this.permissions,
      api1Permissions: api1Permissions ?? this.api1Permissions,
      features: features ?? this.features,
      message: clearMessage ? null : (message ?? this.message),
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  bool get isEmpty => companies.isEmpty;
  bool get hasCompanies => companies.isNotEmpty;
  bool get hasClient => client != null;

  bool hasPermission(String permission) => permissions.contains(permission);
  bool hasAnyPermission(List<String> perms) =>
      perms.any((p) => permissions.contains(p));

  bool hasApi1Permission(String permission) =>
      api1Permissions.contains(permission);
  bool hasAnyApi1Permission(List<String> perms) =>
      perms.any((p) => api1Permissions.contains(p));

  @override
  List<Object?> get props => [
    status,
    companies,
    selectedCompany,
    client,
    permissions,
    api1Permissions,
    features,
    message,
    isSubmitting,
  ];
}
