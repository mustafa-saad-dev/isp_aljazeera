class ResetPasswordRequest {
  final String identifier;
  final String otp;
  final String password;
  ResetPasswordRequest({
    required this.identifier,
    required this.otp,
    required this.password,
  });
}
