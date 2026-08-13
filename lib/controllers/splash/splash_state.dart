import 'package:equatable/equatable.dart';

import '../../core/status/request_status.dart';
import '../../services/app_update/app_update_service.dart';

class SplashState extends Equatable {
  final RequestStatus status;
  final UpdateInfo? update;
  final bool updateRequired;

  const SplashState({
    this.status = RequestStatus.initial,
    this.update,
    this.updateRequired = false,
  });

  SplashState copyWith({
    RequestStatus? status,
    UpdateInfo? update,
    bool? updateRequired,
    bool clearUpdate = false,
    bool clearUpdateRequired = false,
  }) {
    return SplashState(
      status: status ?? this.status,
      update: clearUpdate ? null : (update ?? this.update),
      updateRequired: clearUpdateRequired
          ? false
          : (updateRequired ?? this.updateRequired),
    );
  }

  bool get isLoading => status == RequestStatus.loading;
  bool get isOffline => status == RequestStatus.offline;
  bool get isReady => status == RequestStatus.success;

  @override
  List<Object?> get props => [status, update, updateRequired];
}
