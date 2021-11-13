import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/components/icon/icon_with_rounded_background.dart';
import 'package:flutter_architecture/core/components/text/high_text.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';

class MenuSwitchButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color? iconBackgroundColor;
  final Color? iconColor;
  final Function(bool value) onPressed;
  final bool showBottomDrawer;
  final bool switchDefaultValue;
  const MenuSwitchButton(
      {Key? key,
      required this.title,
      required this.icon,
      this.iconBackgroundColor,
      this.iconColor,
      required this.onPressed,
      this.showBottomDrawer = true,
      this.switchDefaultValue = false})
      : super(key: key);

  @override
  State<MenuSwitchButton> createState() => _MenuSwitchButtonState();
}

class _MenuSwitchButtonState extends State<MenuSwitchButton> {
  late bool switchDefaultValue;
  @override
  void initState() {
    switchDefaultValue = widget.switchDefaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          switchDefaultValue = !switchDefaultValue;
          widget.onPressed(switchDefaultValue);
        });
      },
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
                          icon: widget.icon,
                          iconColor: widget.iconColor,
                          backgroundColor: widget.iconBackgroundColor,
                          size: context.dynamicHeight(0.04),
                        ),
                      ],
                    )),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      HighText(widget.title),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: context.dynamicHeight(0.04),
                              child: FittedBox(
                                child: Switch(
                                  value: switchDefaultValue,
                                  onChanged: (value) {
                                    setState(() {
                                      switchDefaultValue = value;
                                      widget.onPressed(value);
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (widget.showBottomDrawer)
            Row(
              children: [
                const Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: context.defaultTextColor.withOpacity(0.2),
                    height: context.dynamicHeight(0.0015),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
