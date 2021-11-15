import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';

class CustomInkwell extends StatelessWidget {
  final Function() onTap;
  final Widget child;
  const CustomInkwell({Key? key, required this.onTap, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      borderRadius: BorderRadius.circular(context.lowRadius),
      child: Padding(
        padding: EdgeInsets.all(context.normalPadding),
        child: child,
      ),
    );
  }
}
