import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String avatarUrl;

  const UserModel({
    required this.id,
    required this.name,
    this.email = '',
    this.phone = '',
    this.role = '',
    this.avatarUrl = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      avatarUrl: json['avatar_url'] ?? json['avatarUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'role': role,
    'avatar_url': avatarUrl,
  };

  @override
  List<Object?> get props => [id, name, email, phone, role, avatarUrl];
}
