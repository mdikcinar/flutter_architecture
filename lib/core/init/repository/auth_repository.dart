import 'package:flutter_architecture/core/base/model/user_model.dart';

import '../../init/auth/auth_service.dart';
import '../../init/auth/auth_service_base.dart';
import '../../init/auth/firebase_auth_service.dart';

import '../locator.dart';

enum AuthRepositoryEnums {
  firebaseAuth,
  auth,
}

class AuthRepository implements AuthServiceBase {
  AuthRepositoryEnums authMode = AuthRepositoryEnums.firebaseAuth;
  final _authService = locator<AuthService>();
  final _firebaseAuthService = locator<FirebaseAuthService>();

  @override
  Future<bool?> createUserWithEmailPassword(String email, String password) async {
    if (authMode == AuthRepositoryEnums.auth) {
      return await _authService.createUserWithEmailPassword(email, password);
    }
    return await _firebaseAuthService.createUserWithEmailPassword(email, password);
  }

  @override
  Future<UserModel?> currentUser() async {
    if (authMode == AuthRepositoryEnums.auth) {
      return await _authService.currentUser();
    }
    return await _firebaseAuthService.currentUser();
  }

  @override
  Future<bool> forgotPassword(String email) async {
    if (authMode == AuthRepositoryEnums.auth) {
      return await _authService.forgotPassword(email);
    }
    return await _firebaseAuthService.forgotPassword(email);
  }

  @override
  Future<UserModel?> signInWithApple() async {
    if (authMode == AuthRepositoryEnums.auth) {
      return await _authService.signInWithApple();
    }
    return await _firebaseAuthService.signInWithApple();
  }

  @override
  Future<UserModel?> signInWithEmailPassword(String email, String password) async {
    if (authMode == AuthRepositoryEnums.auth) {
      return await _authService.signInWithEmailPassword(email, password);
    }
    return await _firebaseAuthService.signInWithEmailPassword(email, password);
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    if (authMode == AuthRepositoryEnums.auth) {
      return await _authService.signInWithGoogle();
    }
    return await _firebaseAuthService.signInWithGoogle();
  }

  @override
  Future<bool> signOut() async {
    if (authMode == AuthRepositoryEnums.auth) {
      return await _authService.signOut();
    }
    return await _firebaseAuthService.signOut();
  }
}
