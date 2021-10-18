import 'package:my_app/core/core_lib.dart';
import 'package:my_app/src/login_feature/login_page/login_page_view.dart';
import 'package:my_app/src/managers/cache_manager/cache_manager.dart';
import 'package:my_app/src/sample_feature/home_view.dart';

import 'user_session_manager.dart';
import 'package:my_app/src/models/user_data.dart';

class UserSessionManagerImpl implements UserSessionManager {
  final CacheManager _cacheManager;
  final NavigationService _navigationService;

  UserSessionManagerImpl(this._cacheManager, this._navigationService);

  Future<void> saveUserData(UserData user) {
    return _cacheManager.saveUserData(user);
  }

  Future<void> deleteUserCache() {
    return _cacheManager.deleteUserData();
  }

  Future<void> navigateToHomePageAfterSuccessLogin() async {
    await _cacheManager.saveUserLoggedInStatus(true);

    return _navigationService.setRootPage(HomeView());
  }

  @override
  Future<void> logout() async {
    await deleteUserCache();
    await _cacheManager.saveUserLoggedInStatus(false);
    _navigationService.setRootPage(LoginPageView());
  }
}
