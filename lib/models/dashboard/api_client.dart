class ApiClient {
  final int id;
  final double balance;
  final String? city;
  final String firstname;
  final String lastname;
  final String? email;
  final int forceChangePassword;
  final String? phone;
  final int rewardPoints;
  final String username;
  final int requires2fa;
  final String? country;
  final String avatarData;

  const ApiClient({
    required this.id,
    required this.balance,
    this.city,
    required this.firstname,
    required this.lastname,
    this.email,
    this.forceChangePassword = 0,
    this.phone,
    this.rewardPoints = 0,
    required this.username,
    this.requires2fa = 0,
    this.country,
    this.avatarData = '',
  });

  const ApiClient.empty()
      : id = 0,
        balance = 0,
        city = null,
        firstname = '',
        lastname = '',
        email = null,
        forceChangePassword = 0,
        phone = null,
        rewardPoints = 0,
        username = '',
        requires2fa = 0,
        country = null,
        avatarData = '';

  String get fullName => '$firstname $lastname'.trim();

  factory ApiClient.fromJson(Map<String, dynamic> json) {
    return ApiClient(
      id: json['id'] ?? 0,
      balance: (json['balance'] ?? 0).toDouble(),
      city: json['city'],
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'],
      forceChangePassword: json['force_change_password'] ?? 0,
      phone: json['phone'],
      rewardPoints: json['reward_points'] ?? 0,
      username: json['username'] ?? '',
      requires2fa: json['requires_2fa'] ?? 0,
      country: json['country'],
      avatarData: json['avatar_data'] ?? '',
    );
  }
}

class AuthClientResponse {
  final int status;
  final ApiClient client;
  final List<String> permissions;
  final List<String> features;
  final String licenseStatus;

  const AuthClientResponse({
    required this.status,
    required this.client,
    required this.permissions,
    required this.features,
    required this.licenseStatus,
  });

  factory AuthClientResponse.fromJson(Map<String, dynamic> json) {
    return AuthClientResponse(
      status: json['status'] ?? 0,
      client: json['client'] is Map<String, dynamic>
          ? ApiClient.fromJson(json['client'])
          : const ApiClient.empty(),
      permissions: (json['permissions'] as List<dynamic>? ?? [])
          .map((p) => p.toString())
          .toList(),
      features: (json['features'] as List<dynamic>? ?? [])
          .map((f) => f.toString())
          .toList(),
      licenseStatus: json['license_status']?.toString() ?? '',
    );
  }

  bool hasPermission(String permission) => permissions.contains(permission);
  bool hasFeature(String feature) => features.contains(feature);
}
