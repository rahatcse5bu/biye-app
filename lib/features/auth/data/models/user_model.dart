// Auth Feature - Data Layer - Models
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();
  
  const factory UserModel({
    @JsonKey(name: '_id') required String id,
    required String email,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'user_role') required String userRole,
    @JsonKey(name: 'user_status') required String userStatus,
    @JsonKey(name: 'token_id') String? tokenId,
    String? token,
    String? name,
    String? gender,
    String? fcmToken,
    @Default(0) int points,
    @JsonKey(name: 'edited_timeline_index') @Default(0) int editedTimelineIndex,
    @JsonKey(name: 'last_edited_timeline_index') @Default(0) int lastEditedTimelineIndex,
  }) = _UserModel;
  
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  
  // Convert Model to Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      userId: userId,
      userRole: userRole,
      userStatus: userStatus,
      tokenId: tokenId,
      token: token,
      name: name,
      gender: gender,
      fcmToken: fcmToken,
      points: points,
      editedTimelineIndex: editedTimelineIndex,
      lastEditedTimelineIndex: lastEditedTimelineIndex,
    );
  }
  
  // Convert Entity to Model
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      userId: entity.userId,
      userRole: entity.userRole,
      userStatus: entity.userStatus,
      tokenId: entity.tokenId,
      token: entity.token,
      name: entity.name,
      gender: entity.gender,
      fcmToken: entity.fcmToken,
      points: entity.points,
      editedTimelineIndex: entity.editedTimelineIndex,
      lastEditedTimelineIndex: entity.lastEditedTimelineIndex,
    );
  }
}
