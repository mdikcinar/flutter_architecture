import 'package:flutter/material.dart';
import '../../extensions/context_extension.dart';

class TextWithIcon extends StatelessWidget {
  const TextWithIcon({
    required this.text,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final String text;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.normalPadding),
      child: Row(
        children: [
          icon,
          SizedBox(width: context.normalPadding),
          Text(
            text,
            //style: TextStyle(color: Theme.of(context).textTheme.bodyText2!.color!.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
