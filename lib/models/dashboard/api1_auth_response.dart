class Api1User {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? role;
  final String? avatar;

  const Api1User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.role,
    this.avatar,
  });

  factory Api1User.fromJson(Map<String, dynamic> json) {
    return Api1User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      role: json['role'],
      avatar: json['avatar'],
    );
  }
}

class Api1AuthResponse {
  final int status;
  final Api1User user;
  final List<String> permissions;

  const Api1AuthResponse({
    required this.status,
    required this.user,
    required this.permissions,
  });

  factory Api1AuthResponse.fromJson(Map<String, dynamic> json) {
    return Api1AuthResponse(
      status: json['status'] ?? 0,
      user: json['user'] is Map<String, dynamic>
          ? Api1User.fromJson(json['user'])
          : const Api1User(id: 0, name: '', email: ''),
      permissions: (json['permissions'] as List<dynamic>? ?? [])
          .map((p) => p.toString())
          .toList(),
    );
  }

  bool hasPermission(String permission) => permissions.contains(permission);
}
