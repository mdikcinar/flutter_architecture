import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';
import 'package:flutter_architecture/core/extensions/string_extension.dart';

class NormalText extends StatelessWidget {
  final String text;
  final bool bold;
  final Color? color;
  final bool locale;

  const NormalText(this.text, {Key? key, this.bold = false, this.color, this.locale = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      locale ? text.locale : text,
      style: TextStyle(fontSize: context.normalTextSize, fontWeight: bold ? FontWeight.bold : FontWeight.normal, color: color),
    );
  }
}
