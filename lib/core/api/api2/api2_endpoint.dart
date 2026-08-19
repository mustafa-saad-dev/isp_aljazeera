class Api2Endpoints {
  Api2Endpoints._();

  static const String baseUrl = 'https://sasradius.example.com';

  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String forgotPassword = '/api/v1/forgot-password';
  static const String verifyOtp = '/api/v1/verify-otp';
  static const String resetPassword = '/api/v1/reset-password';
}
