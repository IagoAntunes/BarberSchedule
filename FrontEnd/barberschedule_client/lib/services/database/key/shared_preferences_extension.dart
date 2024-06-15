import 'package:shared_preferences/shared_preferences.dart';

extension SharedPreferencesExtension on SharedPreferences {
  dynamic getData(String key) {
    var value = get(key);
    return value;
  }

  void saveData(String key, dynamic value) {
    if (value is String) {
      setString(key, value);
    } else if (value is int) {
      setInt(key, value);
    } else if (value is double) {
      setDouble(key, value);
    } else if (value is bool) {
      setBool(key, value);
    } else if (value is List<String>) {
      setStringList(key, value);
    }
  }
}
