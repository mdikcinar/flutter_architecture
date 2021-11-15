import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';
import 'package:flutter_architecture/core/extensions/string_extension.dart';

class TitleText extends StatelessWidget {
  final String text;
  final bool bold;
  final Color? color;

  const TitleText(this.text, {Key? key, this.bold = false, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.locale,
      style: TextStyle(fontSize: context.titleTextSize, fontWeight: bold ? FontWeight.bold : FontWeight.normal, color: color),
    );
  }
}
