import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';

class IconWithRoundedBackground extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData icon;
  final double? size;
  const IconWithRoundedBackground({Key? key, this.backgroundColor, required this.icon, this.size, this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? context.dynamicHeight(0.05),
      width: size ?? context.dynamicHeight(0.05),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.blue,
        borderRadius: BorderRadius.circular(context.lowRadius),
      ),
      child: Icon(
        icon,
        size: size != null ? (size! / 1.5) : context.dynamicHeight(0.03),
        color: iconColor ?? Colors.white,
      ),
    );
  }
}
