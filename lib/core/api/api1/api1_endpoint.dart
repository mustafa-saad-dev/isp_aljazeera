class Api1Endpoints {
  Api1Endpoints._();

  static const String baseUrl = 'https://api.example.com';

  // ── Auth ──
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String me = '/auth/me';
  static const String logout = '/auth/logout';

  // ── Forgot Password ──
  static const String forgotPassword = '/auth/forgot-password';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resetPassword = '/auth/reset-password';

  // ── Add Company ──
  static const String addCompany = "company";
  static const String getCompanys = 'company';

  // ── App ──
  static const String checkUpdate = '/app/version';

  // ── Transfer Data to Server ──
  static const String transferData = "data/transfer-data";
}
