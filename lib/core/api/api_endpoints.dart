class ApiEndpoints {
  ApiEndpoints._();

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String me = '/auth/me';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String checkUpdate = '/app/version';
}

class SasRadiusEndpoints {
  SasRadiusEndpoints._();

  static const String customers = '/customers';
  static const String plans = '/plans';
  static const String sessions = '/sessions';
  static const String radiusAccounts = '/radius/accounts';
}
