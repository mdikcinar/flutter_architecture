import 'package:flutter/material.dart';
import 'package:flutter_architecture/constants/app_constats.dart';
import 'package:flutter_architecture/constants/navigation_constants.dart';
import 'package:flutter_architecture/core/components/button/menu_button.dart';
import 'package:flutter_architecture/core/components/button/menu_switch_button.dart';
import 'package:flutter_architecture/core/components/card/button_card.dart';
import 'package:flutter_architecture/core/components/card/rounded_card.dart';
import 'package:flutter_architecture/core/components/text/high_text.dart';
import 'package:flutter_architecture/core/components/text/normal_text.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';
import 'package:flutter_architecture/core/extensions/string_extension.dart';
import 'package:flutter_architecture/core/init/language/locale_keys.g.dart';
import 'package:flutter_architecture/core/init/navigation/navigation_service.dart';
import 'package:flutter_architecture/core/init/theme/theme_manager.dart';
import 'package:provider/provider.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.normalPadding),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RoundedCard(
                  title: Row(
                    children: [
                      const HighText(
                        LocaleKeys.backupAndRestore,
                        bold: true,
                      ),
                      SizedBox(width: context.normalPadding),
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 2,
                        child: CircleAvatar(
                          child: Image.asset(
                            ApplicationConstants.googleIconAssetPath,
                            height: 10,
                          ),
                          backgroundColor: Colors.white,
                          radius: 10,
                        ),
                      )
                    ],
                  ),
                  subtitle: const NormalText(LocaleKeys.backupAndRestoreSubtitle),
                  trailing: Icon(Icons.cloud_done_rounded),
                ),
                ButtonCard(
                  title: LocaleKeys.settings,
                  children: [
                    MenuButton(
                      title: LocaleKeys.workoutSettings,
                      icon: Icons.fitness_center_outlined,
                      onPressed: () {},
                    ),
                    MenuButton(
                      title: LocaleKeys.generalSettings,
                      icon: Icons.settings_rounded,
                      onPressed: () {},
                    ),
                    MenuButton(
                      title: LocaleKeys.reminders,
                      icon: Icons.notifications_active,
                      onPressed: () {
                        NavigationService.instance.navigateToPage(path: NavigationConstants.reminderView);
                      },
                    ),
                    MenuButton(
                      title: LocaleKeys.language,
                      icon: Icons.language_rounded,
                      onPressed: () {
                        NavigationService.instance.navigateToPage(path: NavigationConstants.languageView);
                      },
                    ),
                    MenuSwitchButton(
                      title: LocaleKeys.darkmode,
                      icon: Icons.dark_mode_rounded,
                      showBottomDrawer: false,
                      switchDefaultValue: context.read<ThemeManager>().darkMode,
                      onPressed: (value) {
                        context.read<ThemeManager>().changeDarkMode(value);
                      },
                    ),
                  ],
                ),
                ButtonCard(
                  title: LocaleKeys.supportUs,
                  children: [
                    MenuButton(
                      title: LocaleKeys.rateUs,
                      icon: Icons.star_rounded,
                      iconBackgroundColor: Colors.grey,
                      showBottomDrawer: true,
                      onPressed: () {},
                    ),
                    MenuButton(
                      title: LocaleKeys.shareWithFriends,
                      icon: Icons.share_rounded,
                      iconBackgroundColor: Colors.grey,
                      showBottomDrawer: true,
                      onPressed: () {},
                    ),
                    MenuButton(
                      title: LocaleKeys.feedback,
                      icon: Icons.create,
                      iconBackgroundColor: Colors.grey,
                      onPressed: () {},
                    ),
                    MenuButton(
                      title: LocaleKeys.privacyPolicy,
                      icon: Icons.lock_outline_rounded,
                      iconBackgroundColor: Colors.grey,
                      showBottomDrawer: false,
                      onPressed: () {},
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(context.normalPadding),
                  child: Row(
                    children: [
                      NormalText(
                        LocaleKeys.version.locale + ' 1.0.0',
                        locale: false,
                        color: context.defaultTextColor.withOpacity(0.6),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
