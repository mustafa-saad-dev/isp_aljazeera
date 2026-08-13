import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/localization/app_translations.dart';
import '../../core/network/connectivity_service.dart';
import '../../core/network/dio_error_handler.dart';
import '../../core/storage/token_service.dart';
import '../../models/auth/register_model.dart';
import '../../services/auth/auth_service.dart';
import '../../core/status/request_status.dart';
import 'auth_state.dart';

class AuthController extends Cubit<AuthState> {
  AuthController() : super(const AuthState());

  static final AuthController instance = AuthController();

  final AuthService _authService = AuthService();

  Future<void> loadSession() async {
    if (isClosed) return;
    emit(state.copyWith(status: RequestStatus.loading, clearMessage: true));

    final token = TokenService.token;
    if (token == null || token.isEmpty) {
      if (isClosed) return;
      emit(const AuthState(status: RequestStatus.empty));
      return;
    }

    try {
      final user = await _authService.me();
      if (isClosed) return;
      emit(state.copyWith(status: RequestStatus.success, user: user));
    } on DioException catch (e) {
      if (isClosed) return;
      final failure = DioErrorHandler.resolve(e);
      await TokenService.clear();
      emit(
        state.copyWith(
          status: failure.status,
          message: failure.message,
          clearUser: true,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      await TokenService.clear();
      emit(
        state.copyWith(
          status: RequestStatus.error,
          message: e.toString(),
          clearUser: true,
        ),
      );
    }
  }

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    if (isClosed) return;
    emit(
      state.copyWith(
        status: RequestStatus.loading,
        clearUser: true,
        clearMessage: true,
      ),
    );

    if (!await ConnectivityService.instance.isOnline()) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: RequestStatus.offline,
          message: AppTranslations.tr('noInternet'),
        ),
      );
      return;
    }

    try {
      final res = await _authService.login(identifier, password);
      await TokenService.save(res.accessToken);
      if (isClosed) return;
      emit(
        state.copyWith(
          status: RequestStatus.success,
          user: res.user,
          clearMessage: true,
        ),
      );
    } on DioException catch (e) {
      if (isClosed) return;
      final failure = DioErrorHandler.resolve(e);
      emit(state.copyWith(status: failure.status, message: failure.message));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(status: RequestStatus.error, message: e.toString()));
    }
  }

  Future<void> register(RegisterRequest req) async {
    if (isClosed) return;
    emit(
      state.copyWith(
        status: RequestStatus.loading,
        clearUser: true,
        clearMessage: true,
      ),
    );

    if (!await ConnectivityService.instance.isOnline()) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: RequestStatus.offline,
          message: AppTranslations.tr('noInternet'),
        ),
      );
      return;
    }

    try {
      await _authService.register(req);
      if (isClosed) return;
      emit(
        state.copyWith(
          status: RequestStatus.success,
          registered: true,
          clearUser: true,
          clearMessage: true,
        ),
      );
    } on DioException catch (e) {
      if (isClosed) return;
      final failure = DioErrorHandler.resolve(e);
      emit(state.copyWith(status: failure.status, message: failure.message));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(status: RequestStatus.error, message: e.toString()));
    }
  }

  Future<void> logout() async {
    await TokenService.clear();
    try {
      await _authService.logout();
    } catch (_) {
      // تجاهل أخطاء الإبلاغ عن تسجيل الخروج.
    }
    if (isClosed) return;
    emit(const AuthState(status: RequestStatus.empty));
  }
}
