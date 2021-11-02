// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map json) => UserModel(
      userID: json['_id'] as String?,
      email: json['email'] as String?,
      userName: json['userName'] as String?,
      name: json['name'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      description: json['description'] as String?,
      photoUrl: json['photoUrl'] as String?,
      notificationToken: json['notificationToken'] as String?,
      isSubscribed: json['isSubscribed'] as bool?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.userID,
      'email': instance.email,
      'userName': instance.userName,
      'name': instance.name,
      'description': instance.description,
      'photoUrl': instance.photoUrl,
      'notificationToken': instance.notificationToken,
      'isSubscribed': instance.isSubscribed,
      'role': instance.role,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
