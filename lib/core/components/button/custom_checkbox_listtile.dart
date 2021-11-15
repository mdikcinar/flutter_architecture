import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/components/button/custom_inkwell.dart';
import 'package:flutter_architecture/core/components/text/extra_high_text.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';

class CustomCheckboxListtile extends StatefulWidget {
  final bool value;
  final String title;
  final bool locale;
  final Function(bool value) onChange;
  const CustomCheckboxListtile({Key? key, required this.value, required this.title, required this.onChange, this.locale = true})
      : super(key: key);

  @override
  _CustomCheckboxListtileState createState() => _CustomCheckboxListtileState();
}

class _CustomCheckboxListtileState extends State<CustomCheckboxListtile> {
  late bool isSelected;
  @override
  void initState() {
    isSelected = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInkwell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onChange(isSelected);
      },
      child: Row(
        children: [
          FittedBox(
            child: SizedBox(
              height: context.extraHighIconSize,
              child: Checkbox(
                value: isSelected,
                onChanged: (value) {
                  setState(() {
                    isSelected = value ?? !isSelected;
                  });
                  widget.onChange(isSelected);
                },
              ),
            ),
          ),
          ExtraHighText(
            widget.title,
            locale: widget.locale,
          ),
        ],
      ),
    );
  }
}
