import 'package:flutter/material.dart';
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
              height: MediaQuery.of(context).size.height * 0.2,
              padding: EdgeInsets.all(10),
              child: SvgPicture.asset(ApplicationConstants.rateUsStarPath, semanticsLabel: 'rate-us'),
            ),
            SizedBox(height: 10),
            Text(
              'Your opinion matter to us!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'If you enjoy using Workout Tracker app, would you mind rating us, then?',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RateWidget(
              onChanged: (value) => rateValue = value,
            ),
            SizedBox(height: 10),
            CustomButton(
              onPressed: () async {
                onPressedRate(rateValue);
              },
              title: 'Rate',
            ),
            TextButton(
              onPressed: () {
                onMaybeLater();
              },
              child: Text('Maybe later'),
            )
          ],
        ),
      );
    },
  );
}
