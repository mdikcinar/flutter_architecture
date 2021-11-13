// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainViewModel on _MainViewModelBase, Store {
  Computed<int>? _$bottomNavBarCurrentIndexComputed;

  @override
  int get bottomNavBarCurrentIndex => (_$bottomNavBarCurrentIndexComputed ??=
          Computed<int>(() => super.bottomNavBarCurrentIndex,
              name: '_MainViewModelBase.bottomNavBarCurrentIndex'))
      .value;

  final _$_bottomNavBarCurrentIndexAtom =
      Atom(name: '_MainViewModelBase._bottomNavBarCurrentIndex');

  @override
  int get _bottomNavBarCurrentIndex {
    _$_bottomNavBarCurrentIndexAtom.reportRead();
    return super._bottomNavBarCurrentIndex;
  }

  @override
  set _bottomNavBarCurrentIndex(int value) {
    _$_bottomNavBarCurrentIndexAtom
        .reportWrite(value, super._bottomNavBarCurrentIndex, () {
      super._bottomNavBarCurrentIndex = value;
    });
  }

  final _$_MainViewModelBaseActionController =
      ActionController(name: '_MainViewModelBase');

  @override
  void changeBottomBarCurrentIndex(int value) {
    final _$actionInfo = _$_MainViewModelBaseActionController.startAction(
        name: '_MainViewModelBase.changeBottomBarCurrentIndex');
    try {
      return super.changeBottomBarCurrentIndex(value);
    } finally {
      _$_MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
bottomNavBarCurrentIndex: ${bottomNavBarCurrentIndex}
    ''';
  }
}
