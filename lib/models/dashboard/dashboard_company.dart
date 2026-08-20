class DashboardCompany {
  final int id;
  final String name;
  final String link;
  final String username;
  final String password;

  const DashboardCompany({
    required this.id,
    required this.name,
    required this.link,
    required this.username,
    required this.password,
  });

  const DashboardCompany.empty()
      : id = 0,
        name = '',
        link = '',
        username = '',
        password = '';

  factory DashboardCompany.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic> ? json['data'] : json;
    return DashboardCompany(
      id: data['id'] ?? 0,
      name: data['name'] ?? '',
      link: data['link'] ?? '',
      username: data['username'] ?? '',
      password: data['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'link': link,
        'username': username,
        'password': password,
      };

  DashboardCompany copyWith({
    int? id,
    String? name,
    String? link,
    String? username,
    String? password,
  }) {
    return DashboardCompany(
      id: id ?? this.id,
      name: name ?? this.name,
      link: link ?? this.link,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
