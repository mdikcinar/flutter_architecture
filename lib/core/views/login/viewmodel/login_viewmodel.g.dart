// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginViewModel on _LoginViewModelBase, Store {
  Computed<LoginFormStatus>? _$loginFormStatusComputed;

  @override
  LoginFormStatus get loginFormStatus => (_$loginFormStatusComputed ??=
          Computed<LoginFormStatus>(() => super.loginFormStatus,
              name: '_LoginViewModelBase.loginFormStatus'))
      .value;

  final _$_loginFormStatusAtom =
      Atom(name: '_LoginViewModelBase._loginFormStatus');

  @override
  LoginFormStatus get _loginFormStatus {
    _$_loginFormStatusAtom.reportRead();
    return super._loginFormStatus;
  }

  @override
  set _loginFormStatus(LoginFormStatus value) {
    _$_loginFormStatusAtom.reportWrite(value, super._loginFormStatus, () {
      super._loginFormStatus = value;
    });
  }

  final _$_LoginViewModelBaseActionController =
      ActionController(name: '_LoginViewModelBase');

  @override
  void changeLoginFormStatus(LoginFormStatus newLoginFormStatus) {
    final _$actionInfo = _$_LoginViewModelBaseActionController.startAction(
        name: '_LoginViewModelBase.changeLoginFormStatus');
    try {
      return super.changeLoginFormStatus(newLoginFormStatus);
    } finally {
      _$_LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loginFormStatus: ${loginFormStatus}
    ''';
  }
}
