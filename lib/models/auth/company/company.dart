class Company {
  final int id;
  final String name;
  final String url;
  final String username;
  final String password;
  final String? logoUrl;

  const Company({
    required this.id,
    required this.name,
    required this.url,
    required this.username,
    required this.password,
    this.logoUrl,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic> ? json['data'] : json;
    return Company(
      id: data['id'] ?? 0,
      name: data['name'] ?? '',
      url: data['url'] ?? '',
      username: data['username'] ?? '',
      password: data['password'] ?? '',
      logoUrl: data['logo_url'] ?? data['logoUrl'],
    );
  }

  Company copyWith({
    int? id,
    String? name,
    String? url,
    String? username,
    String? password,
    String? logoUrl,
    bool clearLogoUrl = false,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      username: username ?? this.username,
      password: password ?? this.password,
      logoUrl: clearLogoUrl ? null : (logoUrl ?? this.logoUrl),
    );
  }
}
