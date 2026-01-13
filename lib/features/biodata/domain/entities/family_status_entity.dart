import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_status_entity.freezed.dart';

@freezed
class FamilyStatusEntity with _$FamilyStatusEntity {
  const factory FamilyStatusEntity({
    String? fatherName,
    String? fatherOccupation,
    String? isFatherAlive,
    String? motherName,
    String? isMotherAlive,
    String? motherOccupation,
    String? numberOfBrothers,
    List<String>? brotherInfo,
    String? numberOfSisters,
    List<String>? sisterInfo,
    String? uncleInfo,
    String? familyEcoCondition,
    String? ecoConditionType,
    String? familyDeeniInfo,
  }) = _FamilyStatusEntity;
}
