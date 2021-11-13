import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/components/card/rounded_card.dart';
import 'package:flutter_architecture/core/components/text/high_text.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';

class ButtonCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ButtonCard({Key? key, required this.title, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      title: HighText(title, bold: true),
      subtitle: Padding(
        padding: EdgeInsets.only(top: context.normalPadding),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
