// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['_id'] as String,
      email: json['email'] as String,
      userId: (json['user_id'] as num).toInt(),
      userRole: json['user_role'] as String,
      userStatus: json['user_status'] as String,
      tokenId: json['token_id'] as String?,
      token: json['token'] as String?,
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      fcmToken: json['fcmToken'] as String?,
      points: (json['points'] as num?)?.toInt() ?? 0,
      editedTimelineIndex:
          (json['edited_timeline_index'] as num?)?.toInt() ?? 0,
      lastEditedTimelineIndex:
          (json['last_edited_timeline_index'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'user_id': instance.userId,
      'user_role': instance.userRole,
      'user_status': instance.userStatus,
      'token_id': instance.tokenId,
      'token': instance.token,
      'name': instance.name,
      'gender': instance.gender,
      'fcmToken': instance.fcmToken,
      'points': instance.points,
      'edited_timeline_index': instance.editedTimelineIndex,
      'last_edited_timeline_index': instance.lastEditedTimelineIndex,
    };
