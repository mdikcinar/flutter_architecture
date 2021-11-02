import 'package:flutter/material.dart';
import '../../extensions/context_extension.dart';

class CustomButton extends StatefulWidget {
  final String? title;
  final String? progressContinuetitle;
  final double? minWith;
  final double? minHeight;
  final double? fontSize;
  final EdgeInsets? padding;
  final Widget? child;
  final Function() onPressed;
  const CustomButton(
      {Key? key,
      this.title,
      this.minWith,
      required this.onPressed,
      this.fontSize,
      this.minHeight,
      this.padding,
      this.child,
      this.progressContinuetitle})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isProgressContinue = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      //minWidth: widget.minWith,
      onPressed: isProgressContinue
          ? null
          : () async {
              setState(() {
                isProgressContinue = true;
              });
              await widget.onPressed();
              setState(() {
                isProgressContinue = false;
              });
            },
      style: TextButton.styleFrom(
        padding: widget.padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Theme.of(context).accentColor, width: 1, style: BorderStyle.solid),
        ),
        backgroundColor: Theme.of(context).buttonTheme.colorScheme!.background,
        minimumSize: widget.minWith != null && widget.minHeight != null ? Size(widget.minWith!, widget.minHeight!) : null,
      ),
      child: widget.title != null
          ? Text(isProgressContinue ? widget.progressContinuetitle ?? '...' : widget.title!,
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(fontSize: widget.fontSize ?? context.highTextSize, color: Theme.of(context).accentColor))
          : widget.child ?? Container(),
    );
  }
}
