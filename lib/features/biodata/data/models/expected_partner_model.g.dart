// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expected_partner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpectedPartnerModelImpl _$$ExpectedPartnerModelImplFromJson(
  Map<String, dynamic> json,
) => _$ExpectedPartnerModelImpl(
  age: json['age'] == null
      ? null
      : AgeRangeModel.fromJson(json['age'] as Map<String, dynamic>),
  color: (json['color'] as List<dynamic>?)?.map((e) => e as String).toList(),
  height: json['height'] == null
      ? null
      : HeightRangeModel.fromJson(json['height'] as Map<String, dynamic>),
  educationalQualifications:
      (json['educational_qualifications'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  zilla: (json['zilla'] as List<dynamic>?)?.map((e) => e as String).toList(),
  maritalStatus: (json['marital_status'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  occupation: (json['occupation'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  economicalCondition: (json['economical_condition'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  expectedCharacteristics: json['expected_characteristics'] as String?,
);

Map<String, dynamic> _$$ExpectedPartnerModelImplToJson(
  _$ExpectedPartnerModelImpl instance,
) => <String, dynamic>{
  'age': instance.age,
  'color': instance.color,
  'height': instance.height,
  'educational_qualifications': instance.educationalQualifications,
  'zilla': instance.zilla,
  'marital_status': instance.maritalStatus,
  'occupation': instance.occupation,
  'economical_condition': instance.economicalCondition,
  'expected_characteristics': instance.expectedCharacteristics,
};

_$AgeRangeModelImpl _$$AgeRangeModelImplFromJson(Map<String, dynamic> json) =>
    _$AgeRangeModelImpl(
      min: (json['min'] as num?)?.toInt(),
      max: (json['max'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AgeRangeModelImplToJson(_$AgeRangeModelImpl instance) =>
    <String, dynamic>{'min': instance.min, 'max': instance.max};

_$HeightRangeModelImpl _$$HeightRangeModelImplFromJson(
  Map<String, dynamic> json,
) => _$HeightRangeModelImpl(
  min: (json['min'] as num?)?.toDouble(),
  max: (json['max'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$HeightRangeModelImplToJson(
  _$HeightRangeModelImpl instance,
) => <String, dynamic>{'min': instance.min, 'max': instance.max};
