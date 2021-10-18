import 'dart:convert';

import 'package:my_app/core/core_lib.dart';
import 'package:my_app/src/models/user_data.dart';
import '../../managers_lib.dart';
import 'gmail_login_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
// Optional clientId
// clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    // 'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class GmailLoginManagerImpl extends GmailLoginManager {
  final UserSessionManager _userSessionManager;

  GmailLoginManagerImpl(this._userSessionManager) {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      _handleGmailNavigation(account);
    });
    _googleSignIn.signInSilently();
  }

  @override
  Future<UserData?> login() async {
    try {
      logout();
      GoogleSignInAccount? result = await _googleSignIn.signIn();
      if (result == null) return null;
      return UserData.fromGmailResponse(result);
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Future<bool> logout() async {
    try {
      await _googleSignIn.disconnect();
      return true;
    } catch (error) {
      print(error);
    }
    return false;
  }

  @override
  Stream<UserData> get onUserLoggedIn => throw UnimplementedError();

  /////////////////////////////////////////////////
  Future<void> _handleGmailNavigation(GoogleSignInAccount? account) async {
    if (account == null) {
      //todo: handle Error
      return;
    }
    var userData = UserData.fromGmailResponse(account);
    await _userSessionManager.saveUserData(userData);
    await _userSessionManager.navigateToHomePageAfterSuccessLogin();
  }
}
