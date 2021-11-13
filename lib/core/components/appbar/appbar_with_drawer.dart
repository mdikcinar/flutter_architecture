import 'package:flutter/material.dart';
import 'package:flutter_architecture/constants/app_constats.dart';

class AppBarWithDrawer extends StatelessWidget with PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String? title;
  const AppBarWithDrawer({
    Key? key,
    required this.scaffoldKey,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () => scaffoldKey.currentState!.openDrawer(),
        child: Image.asset(
          ApplicationConstants.menuIconAssetPath,
          color: Theme.of(context).textTheme.bodyText2!.color,
          fit: BoxFit.scaleDown,
        ),
      ),
      title: title != null ? Text(title!) : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
