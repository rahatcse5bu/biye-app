import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/family_status_entity.dart';

part 'family_status_model.freezed.dart';
part 'family_status_model.g.dart';

@freezed
class FamilyStatusModel with _$FamilyStatusModel {
  const FamilyStatusModel._();
  
  const factory FamilyStatusModel({
    @JsonKey(name: 'father_name') String? fatherName,
    @JsonKey(name: 'father_occupation') String? fatherOccupation,
    @JsonKey(name: 'isFatherAlive') String? isFatherAlive,
    @JsonKey(name: 'mother_name') String? motherName,
    @JsonKey(name: 'isMotherAlive') String? isMotherAlive,
    @JsonKey(name: 'mother_occupation') String? motherOccupation,
    @JsonKey(name: 'number_of_brothers') String? numberOfBrothers,
    @JsonKey(name: 'brother_info') List<String>? brotherInfo,
    @JsonKey(name: 'number_of_sisters') String? numberOfSisters,
    @JsonKey(name: 'sister_info') List<String>? sisterInfo,
    @JsonKey(name: 'uncle_info') String? uncleInfo,
    @JsonKey(name: 'family_eco_condition') String? familyEcoCondition,
    @JsonKey(name: 'eco_condition_type') String? ecoConditionType,
    @JsonKey(name: 'family_deeni_info') String? familyDeeniInfo,
  }) = _FamilyStatusModel;
  
  factory FamilyStatusModel.fromJson(Map<String, dynamic> json) =>
      _$FamilyStatusModelFromJson(json);
  
  FamilyStatusEntity toEntity() {
    return FamilyStatusEntity(
      fatherName: fatherName,
      fatherOccupation: fatherOccupation,
      isFatherAlive: isFatherAlive,
      motherName: motherName,
      isMotherAlive: isMotherAlive,
      motherOccupation: motherOccupation,
      numberOfBrothers: numberOfBrothers,
      brotherInfo: brotherInfo,
      numberOfSisters: numberOfSisters,
      sisterInfo: sisterInfo,
      uncleInfo: uncleInfo,
      familyEcoCondition: familyEcoCondition,
      ecoConditionType: ecoConditionType,
      familyDeeniInfo: familyDeeniInfo,
    );
  }
}
