import 'package:flutter/cupertino.dart';

import 'INavigationService.dart';

class NavigationService implements INavigationService {
  static final NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  bool Function(Route route) get removeAllOldRoutes => (Route<dynamic> route) => false;

  @override
  Future<void> navigateToPage({required String path, Object? object}) async {
    await navigatorKey.currentState!.pushNamed(path, arguments: object);
  }

  @override
  Future<void> navigateToPageClear({required String path, Object? object}) async {
    await navigatorKey.currentState!.pushNamedAndRemoveUntil(path, removeAllOldRoutes, arguments: object);
  }

  Future<void> navigatePop() async {
    navigatorKey.currentState!.pop();
  }
}
