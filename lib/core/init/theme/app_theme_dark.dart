import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppThemeDark extends AppTheme {
  static AppThemeDark? _instance;
  static AppThemeDark? get instance {
    if (_instance == null) return _instance = AppThemeDark._init();
    return _instance;
  }

  AppThemeDark._init();

  ThemeData get theme => myTheme;

  ThemeData get myTheme => ThemeData(
        fontFamily: 'Ubuntu',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: TextTheme(headline6: TextStyle(color: Colors.white, fontFamily: 'Ubuntu', fontSize: 16)),
        ),
        accentColor: Colors.white,
        primaryColor: Colors.amber,
        primarySwatch: Colors.amber, //Search bar selecred icon and curser color, circular indicator
        brightness: Brightness.dark, //disabled search bar icon color
        accentIconTheme: const IconThemeData(color: Colors.white), //Default Icon Color
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.white), //Input hint color
          errorStyle: TextStyle(color: Colors.amber), //error color
        ),
        canvasColor: Colors.black, //scaffold background color

        cardColor: const Color(0xFF221F1F), //Card background color
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.white), //Default text color
          headline6: TextStyle(color: Colors.white), //App bar title
          headline1: TextStyle(color: Colors.amber), //Showmore text
        ),
        iconTheme: const IconThemeData(color: Colors.amber), //Default Icon Color
        primaryIconTheme: IconThemeData(color: Colors.grey.shade600), //Disabled Icon Color
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.6),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.amber),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Colors.amber),
          trackColor: MaterialStateProperty.all(Colors.amber.shade800),
        ),
      );
}
