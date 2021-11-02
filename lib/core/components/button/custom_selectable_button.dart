import 'package:flutter/material.dart';

class CustomSelectableButton extends StatelessWidget {
  final String? title;
  final double? minWith;
  final bool selected;
  final Function() onPressed;
  const CustomSelectableButton({Key? key, required this.title, this.minWith, this.selected = false, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        //minWidth: widget.minWith,
        onPressed: () => onPressed(),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: selected ? Theme.of(context).accentColor : Theme.of(context).textTheme.headline1!.color!,
                width: 1,
                style: BorderStyle.solid),
          ),
          backgroundColor: selected ? Theme.of(context).accentColor : Colors.transparent,
          minimumSize: minWith != null ? Size(minWith!, 40) : null,
        ),
        child: Text(title!,
            style: TextStyle(fontSize: 18, color: selected ? Colors.white : Theme.of(context).textTheme.headline1!.color)));
  }
}
