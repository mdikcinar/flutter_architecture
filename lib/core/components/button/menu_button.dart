import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/components/icon/icon_with_rounded_background.dart';
import 'package:flutter_architecture/core/components/text/high_text.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? iconBackgroundColor;
  final Color? iconColor;
  final Function() onPressed;
  final bool showBottomDrawer;
  const MenuButton(
      {Key? key,
      required this.title,
      required this.icon,
      this.iconBackgroundColor,
      this.iconColor,
      required this.onPressed,
      this.showBottomDrawer = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.01)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        IconWithRoundedBackground(
                          icon: icon,
                          iconColor: iconColor,
                          backgroundColor: iconBackgroundColor,
                          size: context.dynamicHeight(0.04),
                        ),
                      ],
                    )),
                Expanded(
                  flex: 4,
                  child: HighText(title),
                ),
              ],
            ),
          ),
          if (showBottomDrawer)
            Row(
              children: [
                const Expanded(flex: 1, child: SizedBox()),
                Expanded(
                    flex: 4,
                    child: Container(
                      color: context.defaultTextColor.withOpacity(0.2),
                      height: context.dynamicHeight(0.0015),
                    )),
              ],
            )
        ],
      ),
    );
  }
}
