import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager? get instance {
    if (_instance == null) return _instance = LanguageManager._init();
    return _instance;
  }

  LanguageManager._init();

  final enLocale = const Locale('en', 'US');
  final trLocale = const Locale('tr', 'TR');
  final deviceLocale =
      const Locale('en', 'US'); //Locale(Platform.localeName.substring(0, 2), Platform.localeName.substring(3, 5));
  List<Locale> get supportedLocales {
    var locales = [enLocale, trLocale];
    if (locales.contains(deviceLocale)) {
      return locales;
    }
    //locales.add(deviceLocale);
    return locales;
  }

  String currentLanguageText(Locale selectedLocale) {
    if (selectedLocale == enLocale) {
      return 'English';
    } else if (selectedLocale == trLocale) {
      return 'Türkçe';
    } else if (selectedLocale == deviceLocale) {
      return 'Device Locale';
    }
    return selectedLocale.languageCode + '-' + selectedLocale.countryCode.toString();
  }
}
