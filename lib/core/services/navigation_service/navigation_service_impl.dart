import 'package:flutter/material.dart';
import 'package:my_app/core/services/navigation_service/navigation_service.dart';

/// solvbing issue related to navigation
/// for details fowllow: https://github.com/flutter/flutter/issues/64558#issuecomment-772305972

class NavigationServiceImpl implements NavigationService {
  final _navigatorKey = NavigationService.navigatorKey;

  void pop<T>({T? data}) {
    if (Navigator.canPop(_navigatorKey.currentContext!)) {
      _navigatorKey.currentState!.pop(data);
    }
  }

  /// pushes the page to the top of the stack
  Future<T?> push<T>(Widget page) {
    return WidgetsBinding.instance!.waitUntilFirstFrameRasterized.then((value) {
      return _navigatorKey.currentState!.push(MaterialPageRoute<T>(builder: (context) => page));
    });
  }

  /// removes the current page from the navigation stack and push sended page in stack
  Future<T?> pushReplacement<T>(Widget page) {
    return WidgetsBinding.instance!.waitUntilFirstFrameRasterized.then((value) {
      return _navigatorKey.currentState!.pushReplacement(MaterialPageRoute<T>(builder: (context) => page));
    });
  }

  /// removes all pages on the stack and pushes the page to it
  Future<T?> setRootPage<T>(Widget page) {
    return WidgetsBinding.instance!.waitUntilFirstFrameRasterized.then((value) {
      return _navigatorKey.currentState!
          .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => page), (Route<dynamic> route) => false);
    });
  }
}
