import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(context.normalPadding),
      width: context.dynamicWidth(0.2),
      height: context.dynamicHeight(0.005),
      decoration: BoxDecoration(
        color: context.defaultTextColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(context.normalRadius),
      ),
    );
  }
}
