/// save key value pair depending on   shared_preferences: ^2.0.8
abstract class CacheService {

  /// save value into cahce
  Future<bool> saveString(String key, String value);

 Future<String?> getString(String key);

  Future<bool> saveInt(String key, int value);

  Future<int?> getInt(String key);

  Future<bool> saveDouble(String key, double value);

  Future<double?> getDouble(String key);

  Future<bool> saveBool(String key, bool value);

  Future<bool?> getBool(String key);


  Future<bool> deleteKey(String key);

  Future<bool> isKeyExisted(String key);


}
