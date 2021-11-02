import 'package:flutter/material.dart';
import '../../extensions/context_extension.dart';
import '../../extensions/string_extension.dart';
import '../../init/language/locale_keys.g.dart';

class AddToListButtonWithTitle extends StatefulWidget {
  final Function() onTap;
  final bool isWatchList;
  const AddToListButtonWithTitle({Key? key, required this.onTap, this.isWatchList = false}) : super(key: key);

  @override
  _AddToListButtonWithTitleState createState() => _AddToListButtonWithTitleState();
}

class _AddToListButtonWithTitleState extends State<AddToListButtonWithTitle> {
  bool isFunctionRunning = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!isFunctionRunning) {
          setState(() {
            isFunctionRunning = true;
          });
          await widget.onTap();
          setState(() {
            isFunctionRunning = false;
          });
        }
      },
      child: Column(
        children: [
          Icon(
            widget.isWatchList ? Icons.playlist_add_check : Icons.remove_red_eye,
            size: context.highIconSize,
            color: isFunctionRunning ? Colors.grey.shade600 : Theme.of(context).primaryColor,
          ),
          Text(
            widget.isWatchList ? LocaleKeys.movieAddWatchlist.locale : LocaleKeys.movieAddWatchedlist.locale,
            style: TextStyle(
                color: isFunctionRunning ? Colors.grey.shade600 : Theme.of(context).textTheme.headline6!.color!,
                fontSize: context.normalTextSize),
          ),
        ],
      ),
    );
  }
}
