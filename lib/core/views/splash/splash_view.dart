import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/views/login/view/login_view.dart';
import 'package:flutter_architecture/view/main/main_view.dart';
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
    if (firebaseUser != null) {
      return const MainView();
    }
    return const LoginView();
  }
}
