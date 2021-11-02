import '../../extensions/context_extension.dart';
import '../../extensions/string_extension.dart';

import '../../init/language/locale_keys.g.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function(String value) onValueChanged;
  const SearchBar({Key? key, required this.onValueChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: context.normalPadding),
      margin: EdgeInsets.symmetric(horizontal: context.highPadding, vertical: context.normalPadding),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryIconTheme.color ?? Colors.white,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: TextFormField(
          decoration: InputDecoration(
            icon: const Icon(Icons.search),
            hintText: LocaleKeys.tabbarViewSearch.locale,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: -10),
          ),
          textAlignVertical: TextAlignVertical.top,
          onChanged: (value) {
            onValueChanged(value);
          },
        ),
      ),
    );
  }
}
