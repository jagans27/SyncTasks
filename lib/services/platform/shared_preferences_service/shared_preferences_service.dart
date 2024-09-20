import 'package:shared_preferences/shared_preferences.dart';
import 'package:sync_tasks/services/platform/shared_preferences_service/ishared_preferences_service.dart';

class SharedPreferencesService implements ISharedPreferencesService {
  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  @override
  Future<int?> getInt(String key) async {
    try {
      return _prefs.getInt(key);
    } catch (e) {
      print('Error getting int: $e');
      return null;
    }
  }

  @override
  Future<bool> setInt(String key, int value) async {
    try {
      await _prefs.setInt(key, value);
      return true;
    } catch (e) {
      print('Error setting int: $e');
      return false;
    }
  }

  @override
  Future<bool?> getBool(String key) async {
    try {
      return _prefs.getBool(key);
    } catch (e) {
      print('Error getting bool: $e');
      return null;
    }
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    try {
      await _prefs.setBool(key, value);
      return true;
    } catch (e) {
      print('Error setting bool: $e');
      return false;
    }
  }

  @override
  Future<double?> getDouble(String key) async {
    try {
      return _prefs.getDouble(key);
    } catch (e) {
      print('Error getting double: $e');
      return null;
    }
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    try {
      await _prefs.setDouble(key, value);
      return true;
    } catch (e) {
      print('Error setting double: $e');
      return false;
    }
  }

  @override
  Future<String?> getString(String key) async {
    try {
      return _prefs.getString(key);
    } catch (e) {
      print('Error getting string: $e');
      return null;
    }
  }

  @override
  Future<bool> setString(String key, String value) async {
    try {
      await _prefs.setString(key, value);
      return true;
    } catch (e) {
      print('Error setting string: $e');
      return false;
    }
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    try {
      return _prefs.getStringList(key);
    } catch (e) {
      print('Error getting string list: $e');
      return null;
    }
  }

  @override
  Future<bool> setStringList(String key, List<String> items) async {
    try {
      await _prefs.setStringList(key, items);
      return true;
    } catch (e) {
      print('Error setting string list: $e');
      return false;
    }
  }
}
