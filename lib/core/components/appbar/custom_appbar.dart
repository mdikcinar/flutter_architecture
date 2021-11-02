import 'package:flutter/material.dart';
import '../../extensions/context_extension.dart';
import '../../init/navigation/navigation_service.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final bool iconCancel;
  final List<Widget>? actions;
  const CustomAppBar({Key? key, this.title, this.iconCancel = false, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          title ?? '',
          style: TextStyle(fontSize: context.titleTextSize),
        ),
        leading: IconButton(
          onPressed: () => NavigationService.instance.navigatePop(),
          icon: Icon(
            iconCancel ? Icons.clear : Icons.arrow_back,
            size: context.highIconSize,
          ),
        ),
        actions: actions);
  }
}
