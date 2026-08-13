import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  TokenService._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String _tokenKey = 'AUTH_TOKEN';

  static String? _token;

  static String? get token => _token;

  static Future<void> init() async {
    _token = await _storage.read(key: _tokenKey);
  }

  static Future<void> save(String token) async {
    _token = token;
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<void> clear() async {
    _token = null;
    await _storage.delete(key: _tokenKey);
  }
}
