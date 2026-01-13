// Biodata Feature - Data Layer - Models
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/biodata_entity.dart';
import 'address_model.dart';
import 'education_model.dart';
import 'personal_info_model.dart';
import 'family_status_model.dart';
import 'occupation_model.dart';
import 'marital_info_model.dart';
import 'expected_partner_model.dart';

part 'biodata_model.freezed.dart';
part 'biodata_model.g.dart';

@freezed
class BiodataModel with _$BiodataModel {
  const BiodataModel._();
  
  const factory BiodataModel({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'user') required String userId,
    @JsonKey(name: 'user_id') int? userIdNumber,
    @JsonKey(name: 'bio_type') required String bioType,
    @JsonKey(name: 'date_of_birth') required String dateOfBirth,
    required double height,
    required String gender,
    required double weight,
    @JsonKey(name: 'blood_group') required String bloodGroup,
    @JsonKey(name: 'screen_color') required String screenColor,
    required String nationality,
    @JsonKey(name: 'marital_status') required String maritalStatus,
    String? upzilla,
    String? zilla,
    @JsonKey(name: 'views_count') int? viewsCount,
    @JsonKey(name: 'likes_count') int? likesCount,
    @JsonKey(name: 'dislikes_count') int? dislikesCount,
    @JsonKey(name: 'purchases_count') int? purchasesCount,
    @JsonKey(name: 'isFeatured') bool? isFeatured,
    @JsonKey(name: 'isMarriageDone') bool? isMarriageDone,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'updatedAt') String? updatedAt,
    AddressModel? address,
    @JsonKey(name: 'educationQualification') EducationModel? educationQualification,
    PersonalInfoModel? personalInfo,
    FamilyStatusModel? familyStatus,
    OccupationModel? occupation,
    MaritalInfoModel? maritalInfo,
    ExpectedPartnerModel? expectedLifePartner,
  }) = _BiodataModel;
  
  factory BiodataModel.fromJson(Map<String, dynamic> json) =>
      _$BiodataModelFromJson(json);
  
  // Convert Model to Entity
  BiodataEntity toEntity() {
    return BiodataEntity(
      id: id,
      userId: userId,
      userIdNumber: userIdNumber,
      bioType: bioType,
      dateOfBirth: DateTime.parse(dateOfBirth),
      height: height,
      gender: gender,
      weight: weight,
      bloodGroup: bloodGroup,
      screenColor: screenColor,
      nationality: nationality,
      maritalStatus: maritalStatus,
      upzilla: upzilla,
      zilla: zilla,
      viewsCount: viewsCount,
      likesCount: likesCount,
      dislikesCount: dislikesCount,
      purchasesCount: purchasesCount,
      isFeatured: isFeatured,
      isMarriageDone: isMarriageDone,
      createdAt: createdAt != null ? DateTime.parse(createdAt!) : null,
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
      address: address?.toEntity(),
      educationQualification: educationQualification?.toEntity(),
      personalInfo: personalInfo?.toEntity(),
      familyStatus: familyStatus?.toEntity(),
      occupation: occupation?.toEntity(),
      maritalInfo: maritalInfo?.toEntity(),
      expectedLifePartner: expectedLifePartner?.toEntity(),
    );
  }
  
  // Convert Entity to Model
  factory BiodataModel.fromEntity(BiodataEntity entity) {
    return BiodataModel(
      id: entity.id,
      userId: entity.userId,
      userIdNumber: entity.userIdNumber,
      bioType: entity.bioType,
      dateOfBirth: entity.dateOfBirth.toIso8601String(),
      height: entity.height,
      gender: entity.gender,
      weight: entity.weight,
      bloodGroup: entity.bloodGroup,
      screenColor: entity.screenColor,
      nationality: entity.nationality,
      maritalStatus: entity.maritalStatus,
      upzilla: entity.upzilla,
      zilla: entity.zilla,
      viewsCount: entity.viewsCount,
      likesCount: entity.likesCount,
      dislikesCount: entity.dislikesCount,
      purchasesCount: entity.purchasesCount,
      isFeatured: entity.isFeatured,
      isMarriageDone: entity.isMarriageDone,
      createdAt: entity.createdAt?.toIso8601String(),
      updatedAt: entity.updatedAt?.toIso8601String(),
    );
  }
}
