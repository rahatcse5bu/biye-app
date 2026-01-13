// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FamilyStatusModelImpl _$$FamilyStatusModelImplFromJson(
  Map<String, dynamic> json,
) => _$FamilyStatusModelImpl(
  fatherName: json['father_name'] as String?,
  fatherOccupation: json['father_occupation'] as String?,
  isFatherAlive: json['isFatherAlive'] as String?,
  motherName: json['mother_name'] as String?,
  isMotherAlive: json['isMotherAlive'] as String?,
  motherOccupation: json['mother_occupation'] as String?,
  numberOfBrothers: json['number_of_brothers'] as String?,
  brotherInfo: (json['brother_info'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  numberOfSisters: json['number_of_sisters'] as String?,
  sisterInfo: (json['sister_info'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  uncleInfo: json['uncle_info'] as String?,
  familyEcoCondition: json['family_eco_condition'] as String?,
  ecoConditionType: json['eco_condition_type'] as String?,
  familyDeeniInfo: json['family_deeni_info'] as String?,
);

Map<String, dynamic> _$$FamilyStatusModelImplToJson(
  _$FamilyStatusModelImpl instance,
) => <String, dynamic>{
  'father_name': instance.fatherName,
  'father_occupation': instance.fatherOccupation,
  'isFatherAlive': instance.isFatherAlive,
  'mother_name': instance.motherName,
  'isMotherAlive': instance.isMotherAlive,
  'mother_occupation': instance.motherOccupation,
  'number_of_brothers': instance.numberOfBrothers,
  'brother_info': instance.brotherInfo,
  'number_of_sisters': instance.numberOfSisters,
  'sister_info': instance.sisterInfo,
  'uncle_info': instance.uncleInfo,
  'family_eco_condition': instance.familyEcoCondition,
  'eco_condition_type': instance.ecoConditionType,
  'family_deeni_info': instance.familyDeeniInfo,
};
