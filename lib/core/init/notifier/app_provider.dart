import 'package:flutter_architecture/core/init/user/user_manager.dart';
import 'package:flutter_architecture/core/views/splash/viewmodel/splash_viewmodel.dart';

import '../../init/auth/firebase_auth_service.dart';
import '../../init/iappPurchase/puchases_service.dart';
import '../../init/locator.dart';
import '../../init/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ApplicationProvider {
  static ApplicationProvider? _instance;
  static ApplicationProvider? get instance {
    if (_instance == null) return _instance = ApplicationProvider._init();
    return _instance;
  }

  ApplicationProvider._init();

  List<SingleChildWidget> singleItems = [];
  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(
      create: (context) => ThemeManager(),
    ),
    ChangeNotifierProvider(
      create: (context) => InAppPurchaseService(),
    ),
    ChangeNotifierProvider(
      create: (context) => SplashViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserManager(),
    ),
    StreamProvider(
      create: (context) => locator<FirebaseAuthService>().authStatus,
      initialData: null,
    ),
  ];
}
