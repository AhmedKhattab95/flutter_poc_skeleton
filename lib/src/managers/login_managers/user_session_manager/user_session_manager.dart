import 'package:my_app/src/models/user_data.dart';

abstract class UserSessionManager {
  Future<void> saveUserData(UserData user);


  Future<void> deleteUserCache();

  Future<void> logout();

  Future<void> navigateToHomePageAfterSuccessLogin();
}
