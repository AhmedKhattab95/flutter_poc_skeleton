import 'package:shared_preferences/shared_preferences.dart';
import 'cache_service.dart';

class CacheSreviceImpl implements CacheService {
  late SharedPreferences _prefs;
  bool _initalized = false;

  /// must be called before save or retrieve values
  Future<void> _init() async {
    if (_initalized) return;
    _prefs = await SharedPreferences.getInstance();
    _initalized = true;
  }

  @override
  Future<bool> saveString(String key, String value) async {
    await _init();
    var result = _prefs.setString(key, value);
    return result;
  }

  @override
  Future<String?> getString(String key) async {
    await _init();
    var result = _prefs.getString(key);
    return result;
  }

  @override
  Future<bool> saveInt(String key, int value) async {
    await _init();
    var result = _prefs.setInt(key, value);
    return result;
  }

  @override
  Future<int?> getInt(String key) async {
    await _init();
    var result = _prefs.getInt(key);
    return result;
  }

  @override
  Future<bool> saveDouble(String key, double value) async {
    await _init();
    var result = _prefs.setDouble(key, value);
    return result;
  }

  @override
  Future<double?> getDouble(String key) async {
    await _init();
    var result = _prefs.getDouble(key);
    return result;
  }

  @override
  Future<bool> saveBool(String key, bool value) async {
    await _init();
    var result = _prefs.setBool(key, value);
    return result;
  }

  @override
  Future<bool?> getBool(String key) async {
    await _init();
    var result = _prefs.getBool(key);
    return result;
  }

  @override
  Future<bool> deleteKey(String key) async {
    await _init();
    var result = await _prefs.remove(key);
    return result;
  }

  @override
  Future<bool> isKeyExisted(String key) async{
    await _init();
    return _prefs.containsKey(key);
  }
}
