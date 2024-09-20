abstract class ISharedPreferencesService {
  Future<int?> getInt(String key);
  Future<bool> setInt(String key, int value);
  
  Future<bool?> getBool(String key);
  Future<bool> setBool(String key, bool value);
  
  Future<double?> getDouble(String key);
  Future<bool> setDouble(String key, double value);
  
  Future<String?> getString(String key);
  Future<bool> setString(String key, String value);
  
  Future<List<String>?> getStringList(String key);
  Future<bool> setStringList(String key, List<String> items);
}
