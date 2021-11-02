import 'package:flutter/material.dart';

class UpDownButton extends StatelessWidget {
  //final String title;
  //final double minWith;
  final bool isUp;
  final bool shrinkWrap;
  final Function() onPressed;
  const UpDownButton({Key? key, required this.onPressed, this.isUp = true, this.shrinkWrap = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      //minWidth: widget.minWith,
      onPressed: () => onPressed(),
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(0),
        minimumSize: const Size(45, 25),
        tapTargetSize: shrinkWrap ? MaterialTapTargetSize.shrinkWrap : null,
      ),

      child: Icon(isUp ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded),
    );
  }
}
