import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/localization/app_translations.dart';
import '../../core/network/connectivity_service.dart';
import '../../core/network/dio_error_handler.dart';
import '../../core/status/request_status.dart';
import '../../services/auth/auth_service.dart';
import 'forgot_password_state.dart';

class ForgotPasswordController extends Cubit<ForgotPasswordState> {
  ForgotPasswordController() : super(ForgotPasswordState());

  final AuthService _authService = AuthService();

  Future<void> sendOtp(String identifier) async {
    emit(
      state.copyWith(
        status: RequestStatus.loading,
        clearMessage: true,
        identifier: identifier,
      ),
    );

    if (!await ConnectivityService.instance.isOnline()) {
      emit(
        state.copyWith(
          status: RequestStatus.offline,
          message: AppTranslations.tr('noInternet'),
        ),
      );
      return;
    }

    try {
      await _authService.forgotPassword(identifier);

      emit(state.copyWith(status: RequestStatus.success, step: 2));
    } on DioException catch (e) {
      final failure = DioErrorHandler.resolve(e);
      emit(state.copyWith(status: failure.status, message: failure.message));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error, message: e.toString()));
    }
  }

  Future<void> verifyOtp(String otp) async {
    emit(
      state.copyWith(
        status: RequestStatus.loading,
        clearMessage: true,
        otp: otp,
      ),
    );

    if (!await ConnectivityService.instance.isOnline()) {
      emit(
        state.copyWith(
          status: RequestStatus.offline,
          message: AppTranslations.tr('noInternet'),
        ),
      );
      return;
    }

    try {
      await _authService.verifyOtp(state.identifier, otp);
      emit(state.copyWith(status: RequestStatus.success, step: 3));
    } on DioException catch (e) {
      final failure = DioErrorHandler.resolve(e);
      emit(state.copyWith(status: failure.status, message: failure.message));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error, message: e.toString()));
    }
  }

  Future<void> resetPassword(String password) async {
    emit(state.copyWith(status: RequestStatus.loading, clearMessage: true));

    if (!await ConnectivityService.instance.isOnline()) {
      emit(
        state.copyWith(
          status: RequestStatus.offline,
          message: AppTranslations.tr('noInternet'),
        ),
      );
      return;
    }

    try {
      await _authService.resetPassword(state.identifier, state.otp, password);

      emit(state.copyWith(status: RequestStatus.success, step: 4));
    } on DioException catch (e) {
      final failure = DioErrorHandler.resolve(e);
      emit(state.copyWith(status: failure.status, message: failure.message));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error, message: e.toString()));
    }
  }
}
