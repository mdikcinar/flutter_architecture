import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppThemeLight extends AppTheme {
  static AppThemeLight? _instance;
  static AppThemeLight? get instance {
    if (_instance == null) return _instance = AppThemeLight._init();
    return _instance;
  }

  AppThemeLight._init();

  ThemeData get theme => myTheme;

  ThemeData get myTheme => ThemeData(
        fontFamily: 'Ubuntu',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(color: Colors.black87, fontFamily: 'Ubuntu', fontSize: 16),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black87,
            unselectedItemColor: Colors.black87.withOpacity(0.6)),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),

        accentColor: Colors.white,
        primaryColor: Colors.black,
        primarySwatch: Colors.blue, //Search bar selecred icon and curser color, circular indicator
        brightness: Brightness.light, //disabled search bar icon color
        accentIconTheme: const IconThemeData(color: Colors.white), //Default Icon Color

        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.black), //Input hint color
          errorStyle: TextStyle(color: Colors.red), //error color
        ),

        canvasColor: Colors.white, //scaffold background color
        cardColor: Colors.white, //Card background color

        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.black), //Default text color
          headline6: TextStyle(color: Colors.black), //App bar title
          headline1: TextStyle(color: Colors.blue), //Showmore text
        ),

        iconTheme: const IconThemeData(color: Colors.black), //Default Icon Color
        primaryIconTheme: IconThemeData(color: Colors.grey.shade600), //Disabled Icon Color
      );
}
