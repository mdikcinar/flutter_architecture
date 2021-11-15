import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/views/language/language_view.dart';
import 'package:flutter_architecture/core/views/reminder/reminder_view.dart';
import 'package:flutter_architecture/view/main/main_view.dart';
import '/constants/navigation_constants.dart';
import '../../base/view/not_found_navigaiton.dart';
/*import 'package:movieet/view/upgrade_page/view/privacy_page.dart';
import 'package:movieet/view/upgrade_page/view/products_page.dart';
import 'package:movieet/view/upgrade_page/view/terms_page.dart';*/

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.mainView:
        return normalNavigate(const MainView(), NavigationConstants.mainView);
      case NavigationConstants.languageView:
        return normalNavigate(const LanguageView(), NavigationConstants.languageView);
      case NavigationConstants.reminderView:
        return normalNavigate(const ReminderView(), NavigationConstants.reminderView);
      default:
        return MaterialPageRoute(builder: (context) => const NotFoundNavigationWidget());
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, String pageName) {
    return MaterialPageRoute(builder: (context) => widget, settings: RouteSettings(name: pageName));
  }
}
