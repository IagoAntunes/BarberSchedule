import 'package:barberschedule_client/services/database/key/shared_preferences_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  late SharedPreferences _preferences;

  SharedPreferencesService._();

  @visibleForTesting
  SharedPreferencesService.test({required SharedPreferences preferences})
      : _preferences = preferences;

  static SharedPreferencesService get instance =>
      _instance ??= SharedPreferencesService._();

  Future<void> clear() async {
    await _preferences.clear();
  }

  Future<SharedPreferences> init() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  void saveData(String key, dynamic value) {
    _preferences.saveData(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _preferences.setString(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  dynamic getData(String key) {
    return _preferences.getData(key);
  }
}
