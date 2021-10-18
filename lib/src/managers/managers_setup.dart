import 'package:my_app/core/core_lib.dart';

import 'managers_lib.dart';

class ManagerSetup extends Setup {
  ManagerSetup._();

  static ManagerSetup? _instance;

  static ManagerSetup get Instance => (_instance ??= ManagerSetup._());

  @override
  Future<void> setup() async {
    di.registerLazySingleton<CacheManager>(CacheManagerImpl(di<CacheService>()));
    di.registerLazySingleton<UserSessionManager>(UserSessionManagerImpl(di<CacheManager>(), di<NavigationService>()));
    di.registerLazySingleton<FacebookLoginManager>(
        FacebookLoginManagerImpl(UserSessionManagerImpl(di<CacheManager>(), di<NavigationService>())));
    di.registerLazySingleton<GmailLoginManager>(
        GmailLoginManagerImpl(UserSessionManagerImpl(di<CacheManager>(), di<NavigationService>())));
    di.registerLazySingleton<BiometericManager>(BiometericManagerImpl(di<BiometericService>(), di<CacheManager>()));
  }
}
