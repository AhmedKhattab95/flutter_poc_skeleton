import 'package:get_it/get_it.dart';

/// class that will manage DI throught application depends on   get_it: ^7.2.0

final ServiceLocator DI = _ServiceLocatorImpl();

abstract class ServiceLocator {
  const ServiceLocator();

  void registerSingleton<T extends Object>(T instance, {String? instanceName});

  void registerLazySingleton<T extends Object>(T instance, {String? instanceName});

  void registerFactory<T extends Object>(T instance, {String? instanceName});

  void resetRegisteration();

  void unRegister<T extends Object>({String? instanceName});

  T get<T extends Object>({String? instanceName});

  Future<T> getAsync<T extends Object>({String? instanceName});

  /// Callable class so that you can write `DI<MyType>` instead of
  /// `DI.get<MyType>`
  T call<T extends Object>({String? instanceName});
}

class _ServiceLocatorImpl implements ServiceLocator {
  final GetIt _getIt = GetIt.instance;

  _ServiceLocatorImpl();

  @override
  void registerFactory<T extends Object>(T instance, {String? instanceName}) {
    _getIt.registerFactory<T>(() => instance, instanceName: instanceName);
  }

  @override
  void registerLazySingleton<T extends Object>(T instance, {String? instanceName}) {
    _getIt.registerLazySingleton<T>(() => instance, instanceName: instanceName);
  }

  @override
  void registerSingleton<T extends Object>(T instance, {String? instanceName}) {
    _getIt.registerSingleton<T>(instance, instanceName: instanceName);
  }

  @override
  void resetRegisteration() {
    _getIt.reset(dispose: true);
  }

  @override
  void unRegister<T extends Object>({String? instanceName}) {
    _getIt.unregister<T>(instanceName: instanceName);
  }

  @override
  T get<T extends Object>({String? instanceName}) {
    return _getIt.get<T>(instanceName: instanceName);
  }

  @override
  Future<T> getAsync<T extends Object>({String? instanceName}) {
    return _getIt.getAsync<T>(instanceName: instanceName);
  }

  T call<T extends Object>({String? instanceName}) {
    return get<T>(instanceName: instanceName);
  }
}
