import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';
import 'package:flutter_architecture/core/extensions/string_extension.dart';
import 'package:flutter_architecture/core/views/onboard/onboard_view.dart';
import 'package:flutter_architecture/core/views/splash/viewmodel/splash_viewmodel.dart';
import '/core/init/language/locale_keys.g.dart';
import '/core/views/login/view/login_view.dart';
import '/view/main/main_view.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return FutureBuilder(
      future: context.read<SplashViewModel>().initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (context.read<SplashViewModel>().showOnBoardView) {
            return const OnboardView();
          }
          return const MainView();
        }
        return splashView();
      },
    );

    /*if (firebaseUser != null) {
      return const MainView();
    }
    return const LoginView();*/
  }

  Widget splashView() {
    return Scaffold(
      body: Container(
        width: context.dynamicWidth(1),
        height: context.dynamicHeight(1),
        color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: context.dynamicHeight(0.2)),
              child: buildAppNameText,
            ),
          ],
        ),
      ),
    );
  }

  Text get buildAppNameText => Text(
        LocaleKeys.appName.locale.toUpperCase(),
        style: TextStyle(fontSize: context.highTextSize),
      );
}
