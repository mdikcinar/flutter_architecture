import '../../extensions/string_extension.dart';
import '../../init/language/locale_keys.g.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialogWithTextField({
  required BuildContext context,
  required String title,
  required String? subtitle,
  required Function(String value) onPressedYes,
  //bool secButton = false,
  //Function()? onPressedSecButton,
  //String cacelButtonText = 'No',
  //String secButtonText = 'No',
  //String yesButtonText = 'Yes',
}) async {
  var formKey = GlobalKey<FormState>();
  var workoutName;

  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              subtitle != null ? Text(subtitle) : Container(),
              Form(
                key: formKey,
                child: TextFormField(
                  validator: (value) => value != null ? value.textFormFieldEmptyValidator() : null,
                  onSaved: (newValue) => workoutName = newValue,
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                onPressedYes(workoutName);
                Navigator.of(context).pop();
              }
            },
            child: Text(LocaleKeys.generalSave.locale),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(LocaleKeys.generalCancel.locale),
          ),
        ],
      );
    },
  );
}
