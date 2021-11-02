import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/base/model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'auth_service_base.dart';
import '../../init/locator.dart';
import '../../init/network/network_manager.dart';

class AuthService extends AuthServiceBase {
  String baseApiUrl = 'https://movieet.herokuapp.com/api/';
  @override
  Future<bool?> createUserWithEmailPassword(String email, String password) async {
    final data = {'password': password, 'email': email};
    final response = await NetworkManager.instance.post(url: baseApiUrl + 'auth/signup', data: data);
    debugPrint(response.toString());
    return true;
  }

  @override
  Future<bool> forgotPassword(String email) async {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> signInWithApple() async {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> signInWithEmailPassword(String email, String password) async {
    final data = {'password': password, 'email': email};
    var response = await NetworkManager.instance.post(url: baseApiUrl + 'auth/login', data: data);
    if (response is Map) {
      var token = response['token'];
      var message = response['message'];
      var user = response['user'];
      if (token == null) {
        debugPrint(message);
        Fluttertoast.showToast(msg: message);
      } else {
        //locator<DbService>().token = token;
        debugPrint(token);
        var userModel = UserModel().fromJson(user);
        return userModel;
      }
    }
    debugPrint(response);
    Fluttertoast.showToast(msg: response.toString());
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<bool> signOut() async {
    //locator<DbService>().token = null;
    return true;
  }

  @override
  Future<UserModel?> currentUser() async {
    // TODO: implement currentUser
    throw UnimplementedError();
  }
}
