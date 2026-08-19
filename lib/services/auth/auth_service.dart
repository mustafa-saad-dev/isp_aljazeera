import '../../core/api/api1/api1.dart';
import '../../core/api/api1/api1_endpoint.dart';
import '../../models/auth/login_result/login_result.dart';
import '../../models/auth/register_request/register_request.dart';
import '../../models/auth/register_result/register_result.dart';
import '../../models/auth/user_model/user_model.dart';

class AuthService {
  AuthService();

  Future<LoginResult> login(String identifier, String password) async {
    final res = await Api1.dio.post(
      Api1Endpoints.login,
      data: {'emaill': identifier, 'password': password},
    );
    return LoginResult.fromJson(res.data);
  }

  Future<RegisterResult> register(RegisterRequest req) async {
    final res = await Api1.dio.post(
      Api1Endpoints.register,
      data: {
        'name': req.name,
        'email': req.email,
        'password': req.password,
        'phone': req.phone,
      },
    );
    return RegisterResult.fromJson(res.data);
  }

  Future<UserModel> me() async {
    final res = await Api1.dio.get(Api1Endpoints.me);
    return UserModel.fromJson(res.data);
  }

  Future<void> logout() async {
    try {
      await Api1.dio.post(Api1Endpoints.logout);
    } catch (_) {}
  }

  Future<void> forgotPassword(String identifier) async {
    await Api1.dio.post(
      Api1Endpoints.forgotPassword,
      data: {'email': identifier},
    );
  }

  Future<void> verifyOtp(String identifier, String otp) async {
    await Api1.dio.post(
      Api1Endpoints.verifyOtp,
      data: {'email': identifier, 'otp': otp},
    );
  }

  Future<void> resetPassword(
    String identifier,
    String otp,
    String password,
  ) async {
    await Api1.dio.post(
      Api1Endpoints.resetPassword,
      data: {'email': identifier, 'password': password},
    );
  }
}
