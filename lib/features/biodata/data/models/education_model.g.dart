// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EducationModelImpl _$$EducationModelImplFromJson(Map<String, dynamic> json) =>
    _$EducationModelImpl(
      educationMedium: json['education_medium'] as String?,
      highestEduLevel: json['highest_edu_level'] as String?,
      othersEdu: json['others_edu'] as String?,
      deeniEdu: (json['deeni_edu'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sscYear: (json['ssc_year'] as num?)?.toInt(),
      sscGroup: json['ssc_group'] as String?,
      sscResult: json['ssc_result'] as String?,
      diplomaSub: json['diploma_sub'] as String?,
      diplomaInst: json['diploma_inst'] as String?,
      diplomaPassYear: (json['diploma_pass_year'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$EducationModelImplToJson(
  _$EducationModelImpl instance,
) => <String, dynamic>{
  'education_medium': instance.educationMedium,
  'highest_edu_level': instance.highestEduLevel,
  'others_edu': instance.othersEdu,
  'deeni_edu': instance.deeniEdu,
  'ssc_year': instance.sscYear,
  'ssc_group': instance.sscGroup,
  'ssc_result': instance.sscResult,
  'diploma_sub': instance.diplomaSub,
  'diploma_inst': instance.diplomaInst,
  'diploma_pass_year': instance.diplomaPassYear,
};
