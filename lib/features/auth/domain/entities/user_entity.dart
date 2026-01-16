// Auth Feature - Domain Layer - Entities
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String email,
    required int userId,
    required String userRole,
    required String userStatus,
    String? tokenId,
    String? token,
    String? name,
    String? gender,
    String? fcmToken,
    @Default(0) int points,
    @Default(0) int editedTimelineIndex,
    @Default(0) int lastEditedTimelineIndex,
  }) = _UserEntity;
}
