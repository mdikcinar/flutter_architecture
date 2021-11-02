import 'package:flutter/material.dart';
import '../../extensions/context_extension.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Widget? icon;
  final int? maxLength;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  const CustomTextFormField(
      {Key? key,
      this.hintText = '',
      this.icon,
      this.validator,
      this.controller,
      this.obscureText = false,
      this.keyboardType,
      this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      maxLength: maxLength,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: icon,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        focusColor: Theme.of(context).primaryColor,
        errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(context.lowRadius),
        ),
        enabledBorder: UnderlineInputBorder(
          //borderSide: BorderSide(color: Provider.of<ThemeNotifier>(context).darkMode ? Colors.white : Colors.black),
          borderRadius: BorderRadius.circular(context.lowRadius),
        ),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        filled: true,
        contentPadding: const EdgeInsets.all(0),
      ),
      textAlignVertical: TextAlignVertical.center,
    );
  }
}
