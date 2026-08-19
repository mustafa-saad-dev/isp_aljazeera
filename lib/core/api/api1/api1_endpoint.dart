class Api1Endpoints {
  Api1Endpoints._();

  static const String baseUrl = 'https://api.example.com';

  // ── Auth ──
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String me = '/auth/me';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';

  // ── Forgot Password ──
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resetPassword = '/auth/reset-password';

  // ── App ──
  static const String checkUpdate = '/app/version';
}
