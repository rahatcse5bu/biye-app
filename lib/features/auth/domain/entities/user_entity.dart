// Auth Feature - Domain Layer - Entities
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String email,
    String? name,
    String? phone,
    String? profileImage,
    DateTime? createdAt,
  }) = _UserEntity;
}
