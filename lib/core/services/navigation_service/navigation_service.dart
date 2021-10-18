import 'package:flutter/material.dart';

abstract class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  void pop<T>({T? data});

  Future<T?> push<T>(Widget page);

  Future<T?> pushReplacement<T>(Widget page);

  Future<T?> setRootPage<T>(Widget page);
}
