// ignore: file_names
// ignore: file_names
import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/base/model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../extensions/string_extension.dart';
import '../../init/auth/auth_service_base.dart';
import '../../init/locator.dart';
import '../../init/repository/db_repository.dart';
import '../language/locale_keys.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseAuthService extends AuthServiceBase {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService(this._firebaseAuth);

  Future<String> singInAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
      return 'You have signed in Anonymously.';
    } catch (e) {
      return LocaleKeys.authError.locale + ': ' + e.toString();
    }
  }

  @override
  Future<bool?> createUserWithEmailPassword(String email, String password) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        await _firebaseAuth.signOut();
        Fluttertoast.showToast(msg: LocaleKeys.authEmailVerificationHasBeenSend.locale);
        return true;
      }
      Fluttertoast.showToast(msg: LocaleKeys.authEmailVerificationHasBeenSend.locale);
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: LocaleKeys.authEmailIsAlreadyInUse.locale);
      } else if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: LocaleKeys.authWeakPassword.locale);
      }
      debugPrint(e.message);
      Fluttertoast.showToast(msg: LocaleKeys.authError.locale + ': ' + e.message!);
    } catch (e) {
      Fluttertoast.showToast(msg: LocaleKeys.authError.locale + ': ' + e.toString());
      debugPrint(e.toString());
    }
  }

  @override
  Future<UserModel?> signInWithEmailPassword(String email, String password) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user!.emailVerified) {
        Fluttertoast.showToast(msg: LocaleKeys.authSuccesfullySignedIn.locale);
        return _firebaseUserToUserModel(userCredential.user);
      } else {
        await _firebaseAuth.signOut();
        Fluttertoast.showToast(msg: LocaleKeys.authVerifyEmailError.locale);
      }
    } on FirebaseException catch (e) {
      if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: LocaleKeys.authInvalidEmail.locale);
      } else if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: LocaleKeys.authUserNotFound.locale);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: LocaleKeys.authInvalidPassword.locale);
      }
      debugPrint(e.message);
      Fluttertoast.showToast(msg: LocaleKeys.authError.locale + ': ' + e.message!);
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(msg: LocaleKeys.authError.locale + ': ' + e.toString());
    }
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    // ignore: omit_local_variable_types
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        // ignore: omit_local_variable_types
        final GoogleAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        ) as GoogleAuthCredential;
        // ignore: omit_local_variable_types
        await _firebaseAuth.signInWithCredential(credential);
        Fluttertoast.showToast(msg: LocaleKeys.authSuccesfullySignedInWithGoogle.locale);
        return await _firebaseUserToUserModel(_firebaseAuth.currentUser);
      }
      Fluttertoast.showToast(msg: LocaleKeys.authGoogleSignInError.locale);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        //TO-DO
        Fluttertoast.showToast(msg: LocaleKeys.authError.locale + ': ' + e.message!);
      }
      Fluttertoast.showToast(msg: LocaleKeys.authError.locale + ': ' + e.message!);
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: LocaleKeys.authError.locale + ': ' + e.toString());
    }
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<UserModel?> signInWithApple() async {
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      var userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      Fluttertoast.showToast(msg: LocaleKeys.authSuccesfullySignedInWithApple.locale);
      return _firebaseUserToUserModel(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        //TO-DO
        Fluttertoast.showToast(msg: LocaleKeys.authError.locale + ': ' + e.message!);
      }
      Fluttertoast.showToast(msg: LocaleKeys.authError.locale + ': ' + e.message!);
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: LocaleKeys.authError.locale + ': ' + e.toString());
    }
  }

  @override
  Future<bool> signOut() async {
    if (_firebaseAuth.currentUser != null) {
      try {
        await _firebaseAuth.signOut();
        await GoogleSignIn().signOut();
        Fluttertoast.showToast(msg: LocaleKeys.authSuccesfullySignedOut.locale);
        return true;
      } catch (e) {
        Fluttertoast.showToast(msg: LocaleKeys.authError.locale + ': ' + e.toString());
      }
    } else {
      Fluttertoast.showToast(msg: LocaleKeys.authAlreadySignedOut.locale);
    }
    return false;
  }

  @override
  Future<bool> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(msg: LocaleKeys.authEmailVerificationHasBeenSend.locale + email);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'unknown') {
        Fluttertoast.showToast(msg: 'Unkown Error');
      }
      Fluttertoast.showToast(msg: LocaleKeys.authError.locale + ': ' + e.message!);
    } catch (e) {
      Fluttertoast.showToast(msg: LocaleKeys.authError.locale + ': ' + e.toString());
    }
    return false;
  }

  Stream<User?> get authStatus => _firebaseAuth.authStateChanges();

  Future<UserModel?> _firebaseUserToUserModel(User? firebaseUser) async {
    DbRepository _dbRepository = locator<DbRepository>();
    if (firebaseUser != null) {
      /*var cloudUserModel = await _dbRepository.getCurrentUser();
      if (cloudUserModel != null && cloudUserModel.userID != null) {
        debugPrint('Firebase user to Usermodel: user read from cloud');
        return cloudUserModel;
      } else {
        await _firebaseAuth.signOut();
        debugPrint('Firebase user to Usermodel: Cloud user model couldnt find error.');
      }*/
    }
  }

  @override
  Future<UserModel?> currentUser() async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      return _firebaseUserToUserModel(currentUser);
    }
  }

  Future<String?> getIdToken() async {
    if (_firebaseAuth.currentUser != null) {
      return await _firebaseAuth.currentUser!.getIdToken();
    }
  }
}
