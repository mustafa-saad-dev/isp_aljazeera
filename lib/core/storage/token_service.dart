import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  TokenService._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _api1Key = 'API1_TOKEN';
  static String? _api1Token;
  static String? _api2Token;

  static String? get token => _api1Token;

  static String getApi1Token() => _api1Token ?? '';
  static String getApi2Token() => _api2Token ?? '';

  static Future<void> init() async {
    _api1Token = await _storage.read(key: _api1Key);
  }

  // ── API 1: always persistent ──
  static Future<void> saveApi1(String token, {bool rememberMy = false}) async {
    _api1Token = token;
    if (rememberMy) {
      await _storage.write(key: _api1Key, value: token);
    }
  }

  static Future<void> clearApi1() async {
    _api1Token = null;
    await _storage.delete(key: _api1Key);
  }

  static void setApi2(String token) {
    _api2Token = token;
  }

  static Future<void> clearApi2() async {
    _api2Token = null;
  }

  static Future<void> save(String token) => saveApi1(token);
  static Future<void> clear() => clearApi1();
}
