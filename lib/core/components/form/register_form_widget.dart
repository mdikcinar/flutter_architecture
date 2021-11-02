import '../../components/textformfileld/custom_textformfield.dart';
import '../../extensions/string_extension.dart';

import '../../init/language/locale_keys.g.dart';

import '../button/custom_button.dart';
import 'package:flutter/material.dart';

class RegisterFormWidget extends StatefulWidget {
  final Function(String email, String password) signUpOnPressed;
  final Function() gotoSignInOnPressed;
  const RegisterFormWidget({Key? key, required this.signUpOnPressed, required this.gotoSignInOnPressed}) : super(key: key);

  @override
  _RegisterFormWidgetState createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  GlobalKey<FormState>? formKey;
  TextEditingController? email;
  TextEditingController? password;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    formKey ?? formKey!.currentState!.dispose();
    email!.dispose();
    password!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Wrap(
              spacing: 8,
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: buildEmailFormField,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: buildPasswordFormField,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: buildConfirmPasswordFormField,
                ),
                const SizedBox(height: 10),
                buildSignUpButton(email, password),
              ],
            ),
          ),
          Expanded(
              child: Column(
            children: [
              buildGotoSignInButton(context),
            ],
          )),
        ],
      ),
    );
  }

  CustomTextFormField get buildEmailFormField => CustomTextFormField(
      controller: email,
      hintText: LocaleKeys.loginEmail.locale,
      keyboardType: TextInputType.emailAddress,
      icon: const Icon(Icons.email_outlined),
      validator: (value) {
        if (value != null) {
          return value.isValidEmail() ? null : LocaleKeys.loginInvalidEmail.locale;
        }
      });

  CustomTextFormField get buildPasswordFormField => CustomTextFormField(
        controller: password,
        hintText: LocaleKeys.loginPassword.locale,
        icon: const Icon(Icons.lock_outlined),
        obscureText: true,
        validator: (value) {
          if (value == '') {
            return LocaleKeys.formValidatorCantBeNull.locale;
          }
          if (value != null) {
            if (value.length < 4) {
              return LocaleKeys.loginWeakPassword.locale;
            }
          }
          return null;
        },
      );

  CustomTextFormField get buildConfirmPasswordFormField => CustomTextFormField(
        hintText: LocaleKeys.registerConfirmPassword.locale,
        obscureText: true,
        icon: const Icon(Icons.lock_outlined),
        validator: (value) {
          if (value == '') {
            return LocaleKeys.formValidatorCantBeNull.locale;
          }
          if (value == password!.text) {
            return null;
          } else {
            return LocaleKeys.registerPasswordsDoesntMatch.locale;
          }
        },
      );

  CustomButton buildSignUpButton(TextEditingController? email, TextEditingController? password) {
    return CustomButton(
      onPressed: () => {
        if (formKey!.currentState!.validate())
          {
            widget.signUpOnPressed(email!.text, password!.text),
          }
      },
      child: SizedBox(
        width: 160,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.registerSignUp.locale, style: const TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
    );
  }

  InkWell buildGotoSignInButton(BuildContext context) {
    return InkWell(
      onTap: () => widget.gotoSignInOnPressed(),
      child: Text(
        LocaleKeys.registerAlreadyHasAccount.locale,
        style: TextStyle(color: Theme.of(context).textTheme.headline6!.color),
      ),
    );
  }
}
