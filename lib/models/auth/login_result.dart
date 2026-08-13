import 'user_model.dart';

class LoginResult {
  final String accessToken;
  final UserModel user;

  LoginResult({required this.accessToken, required this.user});

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic> ? json['data'] : json;
    return LoginResult(
      accessToken: data['access_token'] ?? data['token'] ?? '',
      user: UserModel.fromJson(
        data['user'] is Map<String, dynamic> ? data['user'] : data,
      ),
    );
  }
}
