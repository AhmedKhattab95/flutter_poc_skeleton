import 'package:my_app/core/core_lib.dart';
import 'package:my_app/src/sample_feature/home_view.dart';

import 'navigation_manager.dart';

class NavigationManagerImpl extends NavigationManager {
  final NavigationService _navigationService;

  NavigationManagerImpl(this._navigationService);

  @override
  Future<T?> navigateToHomePageAfterSuccessLogin<T>() {
    return _navigationService.setRootPage<T?>(HomeView());
  }
}
