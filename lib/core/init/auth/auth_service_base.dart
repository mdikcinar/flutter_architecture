import '/core/base/model/user_model.dart';

abstract class AuthServiceBase {
  Future<UserModel?> currentUser();
  Future<bool?> createUserWithEmailPassword(String email, String password);
  Future<UserModel?> signInWithEmailPassword(String email, String password);
  Future<UserModel?> signInWithGoogle();
  Future<UserModel?> signInWithApple();
  Future<bool> signOut();
  Future<bool> forgotPassword(String email);
}
