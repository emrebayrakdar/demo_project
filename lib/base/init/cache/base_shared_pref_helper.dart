import 'package:shared_preferences/shared_preferences.dart';

class LocaleService {
  final SharedPreferences _preferences;
  static LocaleService? _instance;

  static Future<LocaleService> getInstance() async {
    _instance ??= LocaleService(remoteConfig: await SharedPreferences.getInstance());
    return _instance!;
  }

  LocaleService({required SharedPreferences remoteConfig}) : _preferences = remoteConfig;

  Future<void> clearAll() async => await _preferences.clear();

  Future<void> setStringValue(String key, String value) async => await _preferences.setString(key.toString(), value);

  Future<void> setBoolValue(String key, bool value) async => await _preferences.setBool(key.toString(), value);

  Future<void> setDouble(String key, double value) async => await _preferences.setDouble(key, value);

  Future<void> setInt(String key, int value) async => await _preferences.setInt(key, value);

  String getStringValue(String key) => _preferences.getString(key.toString()) ?? '';

  bool? getBoolValue(String key) => _preferences.getBool(key.toString());

  int? getInt(String key) => _preferences.getInt(key);

  double? getDouble(String key) => _preferences.getDouble(key);
}
