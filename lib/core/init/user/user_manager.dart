import 'package:flutter/material.dart';
import '/core/base/model/user_model.dart';
import '/constants/enums/preferances_keys_enum.dart';
import '/core/init/auth/auth_service_base.dart';
import '/core/init/cache/cache_manager.dart';
import '/core/init/locator.dart';
import '/core/init/repository/auth_repository.dart';
import '/core/init/repository/db_repository.dart';
import 'dart:convert' as convert;

enum ViewState { idle, busy }

class UserManager with ChangeNotifier implements AuthServiceBase {
  ViewState _state = ViewState.idle;
  final AuthRepository _authRepository = locator<AuthRepository>();
  final DbRepository _dbRepository = locator<DbRepository>();
  UserModel? _userModel;

  int showedAdCount = 0;

  UserModel? get userModel => _userModel;

  set userModel(UserModel? userModel) {
    debugPrint('set user model worked.');
    _userModel = userModel;
    if (_userModel != null) {
      _userModel!.saveUserModeltoLocale();
    } else {
      deleteUserModelFromLocale();
    }
    notifyListeners();
  }

  ViewState get state => _state;
  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel? loadUserModel() {
    if (CacheManager.instance.containsKey(PreferancesKeys.userModel)) {
      debugPrint('UserModel loaded from locale..');
      _userModel = UserModel().fromJson(convert.jsonDecode(CacheManager.instance.getStringValue(PreferancesKeys.userModel)));
      notifyListeners();
      return _userModel;
    }
    debugPrint('There is no usermodel on locale..');
  }

  Future<void> deleteUserModelFromLocale() async {
    await CacheManager.instance.removeKey(PreferancesKeys.userModel);
  }

  @override
  Future<bool?> createUserWithEmailPassword(String email, String password) async {
    try {
      state = ViewState.busy;
      return await _authRepository.createUserWithEmailPassword(email, password);
    } catch (e) {
      debugPrint('User manager create user error: ' + e.toString());
      return false;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<UserModel?> currentUser() async {
    try {
      state = ViewState.busy;
      _userModel = await _authRepository.currentUser() ?? UserModel();
      return _userModel;
    } catch (e) {
      debugPrint('User manager get current user error: ' + e.toString());
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<bool> forgotPassword(String email) async {
    try {
      state = ViewState.busy;
      return await _authRepository.forgotPassword(email);
    } catch (e) {
      debugPrint('User manager forgot pw error: ' + e.toString());
      return false;
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<UserModel?> signInWithApple() async {
    try {
      state = ViewState.busy;
      return await _authRepository.signInWithApple();
    } catch (e) {
      debugPrint('User manager sign in with apple error: ' + e.toString());
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<UserModel?> signInWithEmailPassword(String email, String password) async {
    try {
      state = ViewState.busy;
      var userModelResponse = await _authRepository.signInWithEmailPassword(email, password);
      userModel = userModelResponse;
      return userModel;
    } catch (e) {
      debugPrint('User manager sign in with email pw error: ' + e.toString());
    } finally {
      state = ViewState.idle;
    }
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      state = ViewState.busy;
      userModel = await _authRepository.signInWithGoogle();
      return userModel;
    } catch (e) {
      debugPrint('User manager sign in with google error: ' + e.toString());
    } finally {
      state = ViewState.idle;
    }
  }

  Future<UserModel?> getCurrentUser() async {
    debugPrint('User manager get current user worked');
    /*final newuserModel = await _dbRepository.getCurrentUser();
    if (newuserModel != null) {
      userModel = newuserModel;
      notifyListeners();
    }
    return newuserModel;*/
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.busy;
      var isSignedOut = await _authRepository.signOut();
      if (isSignedOut) {
        userModel = null;
      }
      return isSignedOut;
    } catch (e) {
      debugPrint('User manager sign out error: ' + e.toString());
      return false;
    } finally {
      state = ViewState.idle;
    }
  }
}
