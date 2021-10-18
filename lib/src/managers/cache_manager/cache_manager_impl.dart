import 'dart:convert';

import 'package:my_app/core/core_lib.dart';
import 'package:my_app/src/models/user_data.dart';

import 'cache_manager.dart';

class CacheManagerImpl extends CacheManager {
  final CacheService _cacheService;

  CacheManagerImpl(this._cacheService);

  ///region user data
  final String _userDataKey = 'userDataKey';

  @override
  Future<UserData?> getUserData() async {
    if (await _cacheService.isKeyExisted(_userDataKey)) {
      var data = await _cacheService.getString(_userDataKey);
      Map<String, dynamic> map = json.decode(data ?? '') as Map<String, dynamic>;
      var user = UserData.fromJson(map);
      return user;
    }
    return null;
  }

  @override
  Future<bool> saveUserData(UserData value) {
    var data = json.encode(value.toJson());

    return _cacheService.saveString(_userDataKey, data);
  }

  @override
  Future<bool> deleteUserData() => _cacheService.deleteKey(_userDataKey);

  ///endregion

  ///region user logged in status define if user is logged in or not

  final String _userLoginStatusKey = 'userLogedInKey';

  @override
  Future<bool> saveUserLoggedInStatus(bool status) => _cacheService.saveBool(_userLoginStatusKey, status);

  @override
  Future<bool> isUserLoggedIn() async => (await _cacheService.getBool(_userLoginStatusKey)) ?? false;

  ///endregion
}
