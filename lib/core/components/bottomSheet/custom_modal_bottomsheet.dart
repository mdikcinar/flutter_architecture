import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/components/divider/custom_divider.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';

Future<void> showCustomModalBottomSheet(BuildContext context, {required List<Widget> children}) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(context.dynamicWidth(0.1)),
        topLeft: Radius.circular(context.dynamicWidth(0.1)),
      ),
    ),
    builder: (context) {
      return Column(
        children: [
          const CustomDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.extraHighPadding),
            child: Column(children: children),
          ),
        ],
      );
    },
  );
}
