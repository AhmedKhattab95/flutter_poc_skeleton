import 'dart:convert';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:my_app/core/core_lib.dart';
import 'package:my_app/src/managers/cache_manager/cache_manager.dart';
import 'package:my_app/src/managers/login_managers/user_session_manager/user_session_manager.dart';
import 'package:my_app/src/models/user_data.dart';

import 'facebook_login_manager.dart';

class FacebookLoginManagerImpl extends FacebookLoginManager {
  final UserSessionManager _userSessionManager;
  FacebookLoginManagerImpl(this._userSessionManager);

  @override
  Future<UserData?> login() async {
    try {
      var result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      ); // by default we request the email and the public profile
      if (result == null) return null;

      if (result!.status == LoginStatus.success) {
        // you are logged
        final AccessToken accessToken = result!.accessToken!;
        var fbResult = await FacebookAuth.instance.getUserData();
        String stringJson = json.encode(fbResult);
        //todo: log return from fb
        print(stringJson);
        var user = UserData.fromFacebookResponse(fbResult);
        await _userSessionManager.saveUserData(user);
        //  navigate to home page
        await _userSessionManager.navigateToHomePageAfterSuccessLogin();
        return user;
      } else {
        print(result!.status);
        print(result!.message);
      }
    } catch (error) {
      print(error);
    }
    return null;
  }

  @override
  Future<bool> logout() async {
    try {
      await FacebookAuth.instance.logOut();
      return true;
    } on Exception catch (e) {
      print(e);
    }
    return false;
  }

  @override
  Stream<UserData> get onUserLoggedIn => throw UnimplementedError();
}
