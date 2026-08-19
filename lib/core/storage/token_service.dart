import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _api1Key = 'API1_TOKEN';
  static const String _api2PersistKey = 'API2_TOKEN_PERSIST';
  static const String _api2BaseUrlKey = 'API2_BASE_URL';
  static const String fakeToken = 'FAKE_DASHBOARD_TOKEN';

  static String? _api1Token;
  static String? _api2Token;

  static bool get isFakeToken => _api1Token == fakeToken;

  static String? get token => _api1Token;
  static String getApi1Token() => _api1Token ?? '';
  static String getApi2Token() => _api2Token ?? '';

  static Future<void> init() async {
    _api1Token = await _storage.read(key: _api1Key);
    _api2Token = await _storage.read(key: _api2PersistKey);
  }

  // ── API 1 (always persistent) ──
  static Future<void> saveApi1(String token, {bool rememberMy = false}) async {
    _api1Token = token;
    await _storage.write(key: _api1Key, value: token);
  }

  static Future<void> clearApi1() async {
    _api1Token = null;
    await _storage.delete(key: _api1Key);
  }

  // ── API 2 ──
  static void setApi2(String token) {
    _api2Token = token;
  }

  static Future<void> saveApi2Persistent(String token) async {
    _api2Token = token;
    await _storage.write(key: _api2PersistKey, value: token);
  }

  static Future<void> loadApi2FromStorage() async {
    _api2Token = await _storage.read(key: _api2PersistKey);
  }

  static Future<void> saveApi2BaseUrl(String url) async {
    await _storage.write(key: _api2BaseUrlKey, value: url);
  }

  static Future<String> getApi2BaseUrl() async {
    return await _storage.read(key: _api2BaseUrlKey) ?? '';
  }

  static Future<void> clearApi2() async {
    _api2Token = null;
    await _storage.delete(key: _api2PersistKey);
  }

  // ── Legacy compat ──
  static Future<void> save(String token) => saveApi1(token);
  static Future<void> clear() => clearApi1();
}
