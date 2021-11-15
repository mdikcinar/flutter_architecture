import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/components/text/normal_text.dart';

Future<void> showCustomAlertDialog({
  required BuildContext context,
  required String? title,
  String? subtitle,
  Widget? child,
  required Function() onPressedYes,
  bool secButton = false,
  Function()? onPressedSecButton,
  String cacelButtonText = 'No',
  String secButtonText = 'No',
  String yesButtonText = 'Yes',
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title!),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              if (subtitle != null) NormalText(subtitle),
              if (child != null) child,
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              secButton
                  ? TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onPressedSecButton!();
                      },
                      child: Text(secButtonText),
                    )
                  : Container(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onPressedYes();
                },
                child: Text(yesButtonText),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(cacelButtonText),
              ),
            ],
          ),
        ],
      );
    },
  );
}
