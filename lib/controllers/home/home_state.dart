import '../../core/status/request_status.dart';
import '../../models/dashboard/dashboard_config.dart';
import '../../models/home/home_model.dart';

class HomeState {
  final RequestStatus status;
  final DashboardConfig? config;
  final Map<int, HomeModel> widgetValues;
  final String? message;

  const HomeState({
    this.status = RequestStatus.initial,
    this.config,
    this.widgetValues = const {},
    this.message,
  });

  HomeState copyWith({
    RequestStatus? status,
    DashboardConfig? config,
    Map<int, HomeModel>? widgetValues,
    String? message,
    bool clearMessage = false,
  }) {
    return HomeState(
      status: status ?? this.status,
      config: config ?? this.config,
      widgetValues: widgetValues ?? this.widgetValues,
      message: clearMessage ? null : (message ?? this.message),
    );
  }
}
