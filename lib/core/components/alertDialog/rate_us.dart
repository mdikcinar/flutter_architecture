import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';
import 'package:flutter_architecture/core/extensions/string_extension.dart';
import 'package:flutter_architecture/core/init/language/locale_keys.g.dart';
import '/constants/app_constats.dart';
import '/core/views/rate/ratewidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../button/custom_button.dart';

Future<void> showRateUsDialog({
  required BuildContext context,
  required Function(int value) onPressedRate,
  required Function() onMaybeLater,
}) async {
  var rateValue = 0;
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: context.dynamicHeight(0.2),
              padding: EdgeInsets.all(context.normalPadding),
              child: SvgPicture.asset(ApplicationConstants.rateUsStarPath, semanticsLabel: 'rate-us'),
            ),
            SizedBox(height: context.normalPadding),
            Text(
              LocaleKeys.rateUsTitle.locale,
              style: TextStyle(fontSize: context.highTextSize, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: context.highPadding),
            Text(
              LocaleKeys.rateUsSubtitle.locale,
              style: TextStyle(
                fontSize: context.normalTextSize,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.normalPadding),
            RateWidget(
              onChanged: (value) => rateValue = value,
            ),
            SizedBox(height: context.normalPadding),
            CustomButton(
              onPressed: () async {
                onPressedRate(rateValue);
              },
              title: LocaleKeys.generalRate.locale,
            ),
            TextButton(
              onPressed: () {
                onMaybeLater();
              },
              child: Text(LocaleKeys.maybeLater.locale),
            )
          ],
        ),
      );
    },
  );
}
