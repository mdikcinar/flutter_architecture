import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/components/alertDialog/alert_dialog.dart';
import 'package:flutter_architecture/core/components/text/high_text.dart';
import 'package:flutter_architecture/core/init/language/language_manager.dart';
import 'package:flutter_architecture/core/init/navigation/navigation_service.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HighText('Change Language'),
      ),
      body: ListView(
        children: [
          TextButton(
            onPressed: () async {
              showCustomAlertDialog(
                context: context,
                title: 'Change Language',
                subtitle: 'Are you sure you want to change the language to English?',
                onPressedYes: () async {
                  await context.setLocale(LanguageManager.instance!.enLocale);
                  NavigationService.instance.navigatePop();
                },
              );
            },
            child: const HighText('English'),
          ),
          TextButton(
            onPressed: () async {
              showCustomAlertDialog(
                context: context,
                title: 'Dili Değiştir',
                subtitle: 'Dili Türkçeye çevirmek istediğinizden emin misiniz?',
                yesButtonText: 'Evet',
                cacelButtonText: 'Hayır',
                onPressedYes: () async {
                  await context.setLocale(LanguageManager.instance!.trLocale);
                  NavigationService.instance.navigatePop();
                },
              );
            },
            child: const HighText('Türkçe'),
          )
        ],
      ),
    );
  }
}
