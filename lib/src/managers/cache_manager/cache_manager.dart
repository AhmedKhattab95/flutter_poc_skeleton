import 'package:my_app/src/models/user_data.dart';

abstract class CacheManager {
  Future<bool> isUserLoggedIn();
  Future<bool> saveUserLoggedInStatus(bool status);

  Future<bool> saveUserData(UserData userData);

  Future<UserData?> getUserData();
  Future<bool> deleteUserData();

}
