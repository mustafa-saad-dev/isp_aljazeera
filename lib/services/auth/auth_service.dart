import '../../core/api/api1/api1.dart';
import '../../core/api/api1/api1_endpoint.dart';
import '../../core/config/app_config.dart';
import '../../models/auth/login_result/login_result.dart';
import '../../models/auth/register_request/register_request.dart';
import '../../models/auth/register_result/register_result.dart';
import '../../models/auth/user_model/user_model.dart';

class AuthService {
  AuthService();

  Future<LoginResult> login(String identifier, String password) async {
    if (AppConfig.useFakeApi) return _fakeLogin(identifier);
    final res = await Api1.dio.post(
      Api1Endpoints.login,
      data: {'identifier': identifier, 'password': password},
    );
    return LoginResult.fromJson(res.data);
  }

  Future<RegisterResult> register(RegisterRequest req) async {
    if (AppConfig.useFakeApi) {
      return RegisterResult(id: 2, name: req.name);
    }
    final res = await Api1.dio.post(
      Api1Endpoints.register,
      data: {
        'name': req.name,
        'identifier': req.identifier,
        'password': req.password,
        if (req.email.isNotEmpty) 'email': req.email,
        if (req.phone.isNotEmpty) 'phone': req.phone,
      },
    );
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
    final res = await Api1.dio.get(Api1Endpoints.me);
    return UserModel.fromJson(res.data);
  }

  Future<void> logout() async {
    if (AppConfig.useFakeApi) return;
    try {
      await Api1.dio.post(Api1Endpoints.logout);
    } catch (_) {}
  }

  Future<void> forgotPassword(String identifier) async {
    if (AppConfig.useFakeApi) {
      await Future.delayed(const Duration(seconds: 1));
      return;
    }
    await Api1.dio.post(
      Api1Endpoints.forgotPassword,
      data: {'identifier': identifier},
    );
  }

  Future<void> verifyOtp(String identifier, String otp) async {
    if (AppConfig.useFakeApi) {
      await Future.delayed(const Duration(seconds: 1));
      return;
    }
    await Api1.dio.post(
      Api1Endpoints.verifyOtp,
      data: {'identifier': identifier, 'otp': otp},
    );
  }

  Future<void> resetPassword(
    String identifier,
    String otp,
    String password,
  ) async {
    if (AppConfig.useFakeApi) {
      await Future.delayed(const Duration(seconds: 1));
      return;
    }
    await Api1.dio.post(
      Api1Endpoints.resetPassword,
      data: {'identifier': identifier, 'otp': otp, 'password': password},
    );
  }

  LoginResult _fakeLogin(String identifier) {
    final name =
        identifier.contains('@') ? identifier.split('@').first : identifier;
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
