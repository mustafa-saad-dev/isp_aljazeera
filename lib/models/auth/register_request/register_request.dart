class RegisterRequest {
  final String name;
  final String identifier;
  final String password;
  final String email;
  final String phone;

  RegisterRequest({
    required this.name,
    required this.identifier,
    required this.password,
    this.email = '',
    this.phone = '',
  });
}
