import 'services/service_lib.dart';

abstract class Setup {
  final ServiceLocator di = DI;

  Future<void> setup();
}
