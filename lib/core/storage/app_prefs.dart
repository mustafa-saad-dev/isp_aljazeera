import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  AppPrefs._();

  static final AppPrefs instance = AppPrefs._();

  static SharedPreferences? _prefs;

  Future<SharedPreferences> get _instance async =>
      _prefs ??= await SharedPreferences.getInstance();

  Future<void> setString(String key, String value) async =>
      (await _instance).setString(key, value);

  Future<String?> getString(String key) async =>
      (await _instance).getString(key);

  Future<void> setBool(String key, bool value) async =>
      (await _instance).setBool(key, value);

  Future<bool?> getBool(String key) async => (await _instance).getBool(key);

  Future<void> setInt(String key, int value) async =>
      (await _instance).setInt(key, value);

  Future<int?> getInt(String key) async => (await _instance).getInt(key);

  Future<void> remove(String key) async => (await _instance).remove(key);

  Future<void> clear() async => (await _instance).clear();
}
