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
                      HighText(
                        'Backup & Restore',
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
                  subtitle: NormalText('Sign in and synchronize your data'),
                  trailing: Icon(Icons.cloud_done_rounded),
                ),
                ButtonCard(
                  title: 'Settings',
                  children: [
                    MenuSwitchButton(
                      title: 'Dark Mode',
                      icon: Icons.dark_mode_rounded,
                      showBottomDrawer: true,
                      switchDefaultValue: context.read<ThemeManager>().darkMode,
                      onPressed: (value) {
                        context.read<ThemeManager>().changeDarkMode(value);
                      },
                    ),
                    MenuButton(
                      title: 'Language',
                      icon: Icons.language_rounded,
                      showBottomDrawer: true,
                      onPressed: () {
                        NavigationService.instance.navigateToPage(path: NavigationConstants.languageView);
                      },
                    ),
                    MenuButton(
                      title: 'Settings',
                      icon: Icons.settings_rounded,
                      showBottomDrawer: false,
                      onPressed: () {},
                    ),
                  ],
                ),
                ButtonCard(
                  title: 'Support Us',
                  children: [
                    MenuButton(
                      title: 'Rate Us',
                      icon: Icons.star_rounded,
                      iconBackgroundColor: Colors.grey,
                      showBottomDrawer: true,
                      onPressed: () {},
                    ),
                    MenuButton(
                      title: 'Share With Friends',
                      icon: Icons.share_rounded,
                      iconBackgroundColor: Colors.grey,
                      showBottomDrawer: true,
                      onPressed: () {},
                    ),
                    MenuButton(
                      title: 'Feedback',
                      icon: Icons.create,
                      iconBackgroundColor: Colors.grey,
                      onPressed: () {},
                    ),
                    MenuButton(
                      title: 'Privacy Policy',
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
                        'Version 1.0.0',
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
