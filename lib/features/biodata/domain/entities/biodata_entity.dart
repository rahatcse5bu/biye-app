// Biodata Feature - Domain Layer - Entities
import 'package:freezed_annotation/freezed_annotation.dart';
import 'address_entity.dart';
import 'education_entity.dart';
import 'personal_info_entity.dart';
import 'family_status_entity.dart';
import 'occupation_entity.dart';
import 'marital_info_entity.dart';
import 'expected_partner_entity.dart';

part 'biodata_entity.freezed.dart';

@freezed
class BiodataEntity with _$BiodataEntity {
  const factory BiodataEntity({
    required String id,
    required String userId,
    int? userIdNumber,
    required String bioType,
    required DateTime dateOfBirth,
    required double height,
    required String gender,
    required double weight,
    required String bloodGroup,
    required String screenColor,
    required String nationality,
    required String maritalStatus,
    String? upzilla,
    String? zilla,
    int? viewsCount,
    int? likesCount,
    int? dislikesCount,
    int? purchasesCount,
    bool? isFeatured,
    bool? isMarriageDone,
    DateTime? createdAt,
    DateTime? updatedAt,
    AddressEntity? address,
    EducationEntity? educationQualification,
    PersonalInfoEntity? personalInfo,
    FamilyStatusEntity? familyStatus,
    OccupationEntity? occupation,
    MaritalInfoEntity? maritalInfo,
    ExpectedPartnerEntity? expectedLifePartner,
  }) = _BiodataEntity;
}
