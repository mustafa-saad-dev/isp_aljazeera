import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/device/device_info_service.dart';
import '../../core/network/connectivity_service.dart';
import '../../core/status/request_status.dart';
import '../../services/app_update/app_update_service.dart';
import 'splash_state.dart';

class SplashController extends Cubit<SplashState> {
  final AppUpdateService _updateService = AppUpdateService.instance;

  SplashController() : super(const SplashState(status: RequestStatus.loading));

  Future<void> start() async {
    if (isClosed) return;
    emit(
      state.copyWith(
        status: RequestStatus.loading,
        clearUpdate: true,
        updateRequired: false,
      ),
    );

    final online = await ConnectivityService.instance.isOnline();
    if (isClosed) return;
    if (!online) {
      emit(state.copyWith(status: RequestStatus.offline));
      return;
    }

    try {
      await DeviceInfoService.load();
      if (isClosed) return;

      if (kIsWeb) {
        emit(state.copyWith(status: RequestStatus.success));
        return;
      }

      final update = await _updateService.checkForUpdate();
      if (isClosed) return;

      if (update != null) {
        final needsUpdate = await _updateService.needsUpdate();
        if (isClosed) return;
        emit(
          state.copyWith(
            status: RequestStatus.success,
            update: update,
            updateRequired: update.forceUpdate && needsUpdate,
          ),
        );
      } else {
        emit(state.copyWith(status: RequestStatus.success));
      }
    } catch (_) {
      if (isClosed) return;
      emit(state.copyWith(status: RequestStatus.success));
    }
  }

  void continueAnyway() => emit(
        state.copyWith(
          status: RequestStatus.success,
          clearUpdate: true,
          updateRequired: false,
        ),
      );
}
