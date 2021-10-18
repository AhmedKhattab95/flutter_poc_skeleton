import 'package:my_app/core/core_lib.dart';
import 'managers/managers_setup.dart';

class AppSetup extends Setup {
  ///region signleton
  AppSetup._();

  static AppSetup? _instance;

  static AppSetup get Instance => (_instance ??= AppSetup._());

  /// endregion

  @override
  Future<void> setup() async {
    /// call core registeration
    await CoreSetup.Instance.setup();

    /// register app Managers
    await ManagerSetup.Instance.setup();
  }
}
