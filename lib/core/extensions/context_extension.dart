import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double dynamicHeight(double value) => MediaQuery.of(this).size.height * value;
  double dynamicWidth(double value) => MediaQuery.of(this).size.width * value;

  double get veryExtraLowTextSize => MediaQuery.of(this).size.height * 0.01;
  double get extraLowTextSize => MediaQuery.of(this).size.height * 0.012;
  double get lowTextSize => MediaQuery.of(this).size.height * 0.014;
  double get normalTextSize => MediaQuery.of(this).size.height * 0.017;
  double get highTextSize => MediaQuery.of(this).size.height * 0.02;
  double get extraHighTextSize => MediaQuery.of(this).size.height * 0.025;

  double get titleTextSize => MediaQuery.of(this).size.height * 0.025;

  double get extraLowPadding => MediaQuery.of(this).size.height * 0.0035;
  double get lowPadding => MediaQuery.of(this).size.height * 0.005;
  double get normalPadding => MediaQuery.of(this).size.height * 0.01;
  double get highPadding => MediaQuery.of(this).size.height * 0.02;
  double get extraHighPadding => MediaQuery.of(this).size.height * 0.025;

  double get lowRadius => MediaQuery.of(this).size.height * 0.01;
  double get normalRadius => MediaQuery.of(this).size.height * 0.015;
  double get highRadius => MediaQuery.of(this).size.height * 0.02;
  double get extraHighRadius => MediaQuery.of(this).size.height * 0.025;

  double get extraLowIconSize => MediaQuery.of(this).size.height * 0.05;
  double get normalIconSize => MediaQuery.of(this).size.height * 0.025;
  double get highIconSize => MediaQuery.of(this).size.height * 0.03;
  double get extraHighIconSize => MediaQuery.of(this).size.height * 0.04;
  double get fabSize => MediaQuery.of(this).size.height * 0.07;

  ThemeData get theme => Theme.of(this);
  Color get defaultTextColor {
    if (Theme.of(this).textTheme.bodyText1 != null && Theme.of(this).textTheme.bodyText1!.color != null) {
      return Theme.of(this).textTheme.bodyText1!.color!;
    } else {
      return Colors.white;
    }
  }
}
