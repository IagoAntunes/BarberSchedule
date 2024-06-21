import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService({required SharedPreferences preferences})
      : _preferences = preferences;

  @visibleForTesting
  SharedPreferencesService.test({required SharedPreferences preferences})
      : _preferences = preferences;

  Future<void> clear() async {
    await _preferences.clear();
  }

  void saveData(String key, dynamic value) {
    _preferences.setString(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  dynamic getData(String key) {
    return _preferences.getString(key);
  }
}
