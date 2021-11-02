import 'package:flutter/material.dart';
import '../../extensions/context_extension.dart';

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({required this.label, required this.groupValue, required this.value, required this.onChanged, Key? key})
      : super(key: key);

  final String label;
  final bool groupValue;
  final bool value;
  final Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) onChanged(value);
      },
      child: Row(
        children: <Widget>[
          Radio<bool>(
            groupValue: groupValue,
            value: value,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (bool? newValue) {
              if (newValue != null) onChanged(newValue);
            },
          ),
          Flexible(
              child: Text(
            label,
            style: TextStyle(fontSize: context.normalTextSize),
          )),
        ],
      ),
    );
  }
}
