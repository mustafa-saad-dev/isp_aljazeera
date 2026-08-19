import '../company/company.dart';
import '../user_model/user_model.dart';

class LoginResult {
  final String accessToken;
  final UserModel user;
  final List<Company> companies;

  LoginResult({
    required this.accessToken,
    required this.user,
    this.companies = const [],
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic> ? json['data'] : json;

    final companiesRaw = data['companies'];
    final List<Company> companies;
    if (companiesRaw is List) {
      companies = companiesRaw
          .whereType<Map<String, dynamic>>()
          .map(Company.fromJson)
          .toList();
    } else {
      companies = [];
    }

    return LoginResult(
      accessToken: data['access_token'] ?? data['token'] ?? '',
      user: UserModel.fromJson(
        data['user'] is Map<String, dynamic> ? data['user'] : data,
      ),
      companies: companies,
    );
  }
}
