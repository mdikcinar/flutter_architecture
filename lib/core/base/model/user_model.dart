import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '/constants/enums/preferances_keys_enum.dart';
import '../../base/model/base_model.dart';
import '../../init/cache/cache_manager.dart';
import 'dart:convert' as convert;

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class UserModel extends BaseModel with ChangeNotifier {
  @JsonKey(name: '_id')
  String? userID;
  String? email;
  String? userName;
  String? name;
  String? description;
  String? photoUrl;
  String? notificationToken;
  bool? isSubscribed;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    this.userID,
    this.email,
    this.userName,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.photoUrl,
    this.notificationToken,
    this.isSubscribed,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserModelToJson(this);
  }

  /*Future<UserModel?> saveUserModel() async {
    final savedUserModel = await saveToCloud();
    if (savedUserModel != null) {
      await CacheManager.instance.setStringValue(PreferancesKeys.userModel, convert.jsonEncode(toJson()));
      debugPrint('UserModel saved to device');
    }
    return savedUserModel;
  }*/

  Future<void> saveUserModeltoLocale() async {
    await CacheManager.instance.setStringValue(PreferancesKeys.userModel, convert.jsonEncode(toJson()));
    debugPrint('UserModel saved to device');
  }

  /*Future<UserModel?> saveToCloud() async {
    //final DbRepository _dbRepository = locator<DbRepository>();

    final savedUserModel = await _dbRepository.saveUser(user: this);
    if (savedUserModel != null) {
      debugPrint('UserModel saved to cloud.');
      return savedUserModel;
    }
  }

  Future<bool?> saveSubscriptions(bool isSubscribed, bool isPatron) async {
    debugPrint('Save subscriptions worked');
    //final DbRepository _dbRepository = locator<DbRepository>();
    final isSaved = await _dbRepository.saveSubscriptions(isSubscribed, isPatron);
    if (isSaved) debugPrint('Subscriptions are saved..');
    return isSaved;
  }*/
}
