import 'package:flutter/material.dart';
import '../../extensions/context_extension.dart';

class AddToListButton extends StatefulWidget {
  final Function() onTap;
  final bool isWatchList;
  const AddToListButton({Key? key, required this.onTap, this.isWatchList = false}) : super(key: key);

  @override
  _AddToListButtonState createState() => _AddToListButtonState();
}

class _AddToListButtonState extends State<AddToListButton> {
  bool isFunctionRunning = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isFunctionRunning
          ? null
          : () async {
              setState(() {
                isFunctionRunning = true;
              });
              await widget.onTap();
              setState(() {
                isFunctionRunning = false;
              });
            },
      child: Icon(
        widget.isWatchList ? Icons.playlist_add_check : Icons.remove_red_eye,
        size: context.highIconSize,
        color: isFunctionRunning ? Colors.grey.shade600 : Theme.of(context).primaryColor,
      ),
    );
  }
}
