import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/services/service_lib.dart';
import 'package:my_app/src/managers/managers_lib.dart';

import '../../base_view_model.dart';

final LoginPageViewModelProvider = ChangeNotifierProvider(
    (ref) => LoginPageViewModel(
        DI<BiometericManager>(), DI<FacebookLoginManager>(), DI<GmailLoginManager>(), DI<UserSessionManager>()),
    name: LoginPageViewModel.key);

class LoginPageViewModel extends BaseViewModel {
  static final key = 'LoginPageViewModel';
  final BiometericManager _biometericManager;
  final FacebookLoginManager _facebookLoginManager;
  final GmailLoginManager _gmailLoginManager;
  final UserSessionManager _userSessionManager;

  LoginPageViewModel(
      this._biometericManager, this._facebookLoginManager, this._gmailLoginManager, this._userSessionManager);

  Future<bool> get showBiomerticOptions => _biometericManager.showBiometericOptions();

  Future<void> onBiometericTapped() async {
    bool success = await _biometericManager.requestBiometericLogin("confirm Fingerprint to continue");
    if (success) {
      //navigation to homepage
      _userSessionManager.navigateToHomePageAfterSuccessLogin();
    }
  }

  Future<void> handleFacebookSignIn() async {
    var data = await _facebookLoginManager.login();
    //todo: log
    if (data != null)
      print('login success data : ${data.toString()}');
    else
      print('login failed');
  }

  Future<void> _handleFacebookSignOut() async => await _facebookLoginManager.logout();

  //////////////////////////////////////

  Future<void> handleGmailSignIn() async {
    _gmailLoginManager.login();
  }

  Future<void> _handleGmailSignOut() async => await _gmailLoginManager.logout();

/////////////////////////

}
