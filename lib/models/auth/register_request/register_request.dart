class RegisterRequest {
  final String name;
  final String password;
  final String email;
  final String phone;

  RegisterRequest({
    required this.name,
    required this.password,
    this.email = '',
    this.phone = '',
  });
}
