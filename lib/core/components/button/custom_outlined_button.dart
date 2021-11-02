import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String? title;
  final double? minWith;
  final double? minHeight;
  final double fontSize;
  final Widget? child;
  final Color? borderColor;
  final Color? backgroundcolor;
  final Function() onPressed;
  const CustomOutlinedButton({
    Key? key,
    this.title,
    this.minWith,
    required this.onPressed,
    this.fontSize = 15,
    this.minHeight,
    this.child,
    this.borderColor,
    this.backgroundcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      //minWidth: widget.minWith,
      onPressed: () => onPressed(),
      style: TextButton.styleFrom(
        backgroundColor: backgroundcolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: borderColor ?? Theme.of(context).buttonTheme.colorScheme!.onPrimary,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        minimumSize: minWith != null && minHeight != null ? Size(minWith!, minHeight!) : null,
      ),
      child: title != null
          ? Text(title!,
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(fontSize: fontSize, color: Theme.of(context).buttonTheme.colorScheme!.onPrimary))
          : child!,
    );
  }
}
