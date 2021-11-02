import '/constants/app_constats.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:io' as io;
import '../../init/language/locale_keys.g.dart';
import '../button/custom_button.dart';
import '../../components/textformfileld/custom_textformfield.dart';
import '../../extensions/string_extension.dart';
import 'package:flutter/material.dart';

class SignFormWidget extends StatefulWidget {
  final Function(String email, String password) signInOnPressed;
  final Function() googleSignInOnPressed;
  final Function() appleSignInOnPressed;
  final Function(String email)? forgotPwOnPressed;
  final Function() gotoSignUpOnPressed;
  final Function()? anonymouslySignInOnPressed;
  final bool disableButtons;
  const SignFormWidget(
      {Key? key,
      required this.signInOnPressed,
      required this.googleSignInOnPressed,
      required this.appleSignInOnPressed,
      required this.gotoSignUpOnPressed,
      this.forgotPwOnPressed,
      this.disableButtons = true,
      this.anonymouslySignInOnPressed})
      : super(key: key);
  @override
  _SignFormWidgetState createState() => _SignFormWidgetState();
}

class _SignFormWidgetState extends State<SignFormWidget> {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildEmailFormField(context),
                const SizedBox(height: 8),
                buildPasswordFormField(context),
                const SizedBox(height: 8),
                buildRememberAndForgotPwRow(context),
                const SizedBox(height: 18),
                buildSignInButton,
                const SizedBox(height: 8),
                buildSignInWithGoogleButton,
                const SizedBox(height: 8),
                io.Platform.isIOS ? buildSignInWithAppleButton : Container(),
              ],
            ),
          ),
          Expanded(
            child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              children: [
                buildGotoSignUpFormButton(context),
                //buildAnonymousSignInButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildRememberAndForgotPwRow(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (email!.text.isValidEmail()) {
                widget.forgotPwOnPressed!(email!.text);
              } else {
                formKey!.currentState!.validate();
              }
            },
            child: Text(
              LocaleKeys.loginForgotPassword.locale,
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildEmailFormField(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: CustomTextFormField(
          controller: email,
          keyboardType: TextInputType.emailAddress,
          hintText: LocaleKeys.loginEmail.locale,
          icon: const Icon(Icons.email_outlined),
          validator: (value) {
            if (value != null) {
              return value.isValidEmail() ? null : LocaleKeys.loginInvalidEmail.locale;
            }
          }),
    );
  }

  SizedBox buildPasswordFormField(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: CustomTextFormField(
        controller: password,
        hintText: LocaleKeys.loginPassword.locale,
        icon: const Icon(Icons.lock_outlined),
        obscureText: true,
        validator: (value) {
          if (value == '') {
            return LocaleKeys.loginEmptyPassword.locale;
          }
          if (value != null) {
            if (value.length < 4) {
              return LocaleKeys.loginWeakPassword.locale;
            }
          }

          return null;
        },
      ),
    );
  }

  CustomButton get buildSignInButton => CustomButton(
        onPressed: () {
          if (formKey!.currentState!.validate()) {
            widget.signInOnPressed(email!.text, password!.text);
          }
        },
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          width: 220,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.loginSignInButton.locale,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 44 * 0.43,
                    fontFamily: io.Platform.isIOS ? '.SF Pro Text' : 'Ubuntu'),
              ),
            ],
          ),
        ),
      );

  CustomButton get buildSignInWithGoogleButton => CustomButton(
        onPressed: () {
          widget.googleSignInOnPressed();
        },
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          width: 220,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ApplicationConstants.googleIconAssetPath,
                width: 18,
                color: Colors.white,
              ),
              const SizedBox(width: 6),
              Text(
                LocaleKeys.loginSignInWithGoogle.locale,
                style: TextStyle(
                    color: Colors.white, fontSize: 44 * 0.43, fontFamily: io.Platform.isIOS ? '.SF Pro Text' : 'Ubuntu'),
              ),
            ],
          ),
        ),
      );

  Widget get buildSignInWithAppleButton => SizedBox(
        width: 220,
        child: SignInWithAppleButton(
          text: LocaleKeys.loginSignInWithApple.locale,
          onPressed: () {
            widget.appleSignInOnPressed();
          },
        ),
      );

  InkWell buildGotoSignUpFormButton(BuildContext context) {
    return InkWell(
      onTap: () => widget.gotoSignUpOnPressed(),
      child: Text(
        LocaleKeys.loginSignUp.locale,
        style: TextStyle(color: Theme.of(context).textTheme.headline6!.color),
      ),
    );
  }

  InkWell buildAnonymousSignInButton(BuildContext context) {
    return InkWell(
      onTap: () => widget.anonymouslySignInOnPressed!(),
      child: Text(
        LocaleKeys.loginAnonymous.locale,
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
    );
  }
}
