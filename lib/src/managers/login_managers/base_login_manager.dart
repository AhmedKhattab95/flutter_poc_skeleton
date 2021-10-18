import 'package:my_app/core/core_lib.dart';
import 'package:my_app/src/models/user_data.dart';
import 'package:my_app/src/sample_feature/home_view.dart';

import '../managers_lib.dart';

abstract class BaseLoginManager {


  Stream<UserData> get onUserLoggedIn;

  Future<UserData?> login();

  Future<bool> logout();


}
