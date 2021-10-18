import 'package:my_app/core/core_lib.dart';
import 'package:my_app/src/managers/cache_manager/cache_manager.dart';

import 'biometeric_manager.dart';

class BiometericManagerImpl extends BiometericManager {
  final BiometericService _biometericService;
  final CacheManager _cacheManager;

  BiometericManagerImpl(this._biometericService, this._cacheManager);

  @override
  Future<bool> showBiometericOptions() async {
    // check if user is already logged in
    bool usserLoggedIn = await _cacheManager.isUserLoggedIn();
    if (!usserLoggedIn ) return false;
    // check if device has any biometerics
    bool biometericExisted = await _biometericService.isbiometericsAvilable;
    if (!biometericExisted) return false;
    // user logged in and biometeric existed
    return true;
  }

  @override
  Future<bool> isFaceIdAvilable() => _biometericService.isFaceRecognitionAvilable;

  @override
  Future<bool> isFingerPrintAvilable() => _biometericService.isFingerPrintAvilable;

  @override
  Future<bool> requestBiometericLogin(String localizedMessage) {
    return _biometericService.requestAuthenticate(localizedMessage: localizedMessage);
  }
}
