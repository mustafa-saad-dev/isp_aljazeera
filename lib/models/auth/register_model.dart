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

  Map<String, dynamic> toJson() => {
    'name': name,
    'identifier': identifier,
    'password': password,
    if (email.isNotEmpty) 'email': email,
    if (phone.isNotEmpty) 'phone': phone,
  };
}

class RegisterResult {
  final int id;
  final String name;

  RegisterResult({required this.id, required this.name});

  factory RegisterResult.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic> ? json['data'] : json;
    final user = data['user'] is Map<String, dynamic> ? data['user'] : data;
    return RegisterResult(id: user['id'] ?? 0, name: user['name'] ?? '');
  }
}
