import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';

class RoundedCard extends StatelessWidget {
  final Widget? subtitle;
  final Widget title;
  final Widget? trailing;
  const RoundedCard({Key? key, required this.title, this.subtitle, this.trailing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(context.normalRadius))),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: context.highPadding, vertical: context.normalPadding),
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      ),
    );
  }
}
