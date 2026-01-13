// Auth Feature - Data Layer - Models
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();
  
  const factory UserModel({
    required String id,
    required String email,
    String? name,
    String? phone,
    String? profileImage,
    DateTime? createdAt,
  }) = _UserModel;
  
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  
  // Convert Model to Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      phone: phone,
      profileImage: profileImage,
      createdAt: createdAt,
    );
  }
  
  // Convert Entity to Model
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      phone: entity.phone,
      profileImage: entity.profileImage,
      createdAt: entity.createdAt,
    );
  }
}
