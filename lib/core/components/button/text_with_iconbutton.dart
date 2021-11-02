import 'package:flutter/material.dart';
import '../../extensions/context_extension.dart';

class TextWithIconButton extends StatelessWidget {
  const TextWithIconButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String text;
  final Widget icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Padding(
        padding: EdgeInsets.all(context.normalPadding),
        child: Row(
          children: [
            icon,
            SizedBox(width: context.normalPadding),
            Text(
              text,
              style: TextStyle(fontSize: context.normalTextSize),
            ),
          ],
        ),
      ),
    );
  }
}
