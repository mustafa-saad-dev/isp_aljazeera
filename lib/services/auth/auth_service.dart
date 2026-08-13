import 'package:dio/dio.dart';

import '../../core/api/api_client.dart';
import '../../core/api/api_endpoints.dart';
import '../../core/config/app_config.dart';
import '../../models/auth/login_result.dart';
import '../../models/auth/register_model.dart';
import '../../models/auth/user_model.dart';

class AuthService {
  AuthService({Dio? dio}) : _dio = dio ?? ApiClient.dio;

  final Dio _dio;

  Future<LoginResult> login(String identifier, String password) async {
    if (AppConfig.useFakeApi) return _fakeLogin(identifier);
    final res = await _dio.post(
      ApiEndpoints.login,
      data: {'identifier': identifier, 'password': password},
    );
    return LoginResult.fromJson(res.data);
  }

  Future<RegisterResult> register(RegisterRequest req) async {
    if (AppConfig.useFakeApi) {
      return RegisterResult(id: 2, name: req.name);
    }
    final res = await _dio.post(ApiEndpoints.register, data: req.toJson());
    return RegisterResult.fromJson(res.data);
  }

  Future<UserModel> me() async {
    if (AppConfig.useFakeApi) {
      return const UserModel(
        id: 1,
        name: 'المستخدم',
        email: 'user@example.com',
        role: 'agent',
      );
    }
    final res = await _dio.get(ApiEndpoints.me);
    return UserModel.fromJson(res.data);
  }

  Future<void> logout() async {
    if (AppConfig.useFakeApi) return;
    try {
      await _dio.post(ApiEndpoints.logout);
    } catch (_) {}
  }

  LoginResult _fakeLogin(String identifier) {
    final name = identifier.contains('@')
        ? identifier.split('@').first
        : identifier;
    return LoginResult(
      accessToken: 'fake_access_${DateTime.now().millisecondsSinceEpoch}',
      user: UserModel(
        id: 1,
        name: name,
        email: identifier.contains('@')
            ? identifier
            : '$identifier@example.com',
        phone: identifier.contains('@') ? '' : identifier,
        role: 'agent',
      ),
    );
  }
}
