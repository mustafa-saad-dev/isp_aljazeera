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
