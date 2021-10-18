import 'package:my_app/core/setup.dart';

import 'core_lib.dart';

class CoreSetup extends Setup {
  CoreSetup._();

  static CoreSetup? _instance;

  static CoreSetup get Instance => (_instance ??= CoreSetup._());

  @override
  Future<void> setup() async {
    ///region register services
    di.registerLazySingleton<CacheService>(CacheSreviceImpl());
    di.registerLazySingleton<BiometericService>(BiometericServiceImpl());
    di.registerLazySingleton<NavigationService>(NavigationServiceImpl());

    ///endregion

    ///region======= regiser managers
    ///endregion
  }
}
