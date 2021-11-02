import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/core/views/splash/splash_view.dart';
import 'package:provider/provider.dart';

import 'constants/app_constats.dart';
import 'core/init/cache/cache_manager.dart';
import 'core/init/language/language_manager.dart';
import 'core/init/locator.dart';
import 'core/init/navigation/navgation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/notifier/app_provider.dart';
import 'core/init/theme/theme_manager.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await CacheManager.sharedPreferencesInit();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiProvider(
      providers: [
        ...ApplicationProvider.instance!.dependItems,
      ],
      child: EasyLocalization(
        supportedLocales: LanguageManager.instance!.supportedLocales,
        path: ApplicationConstants.languagesAssetPath,
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      theme: context.watch<ThemeManager>().currentTheme(),
      title: 'Flutter Architecture',
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      home: const SplashView(),
    );
  }
}
