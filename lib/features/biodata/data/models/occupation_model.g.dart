// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occupation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OccupationModelImpl _$$OccupationModelImplFromJson(
  Map<String, dynamic> json,
) => _$OccupationModelImpl(
  occupation: (json['occupation'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  occupationDetails: json['occupation_details'] as String?,
  monthlyIncome: (json['monthly_income'] as num?)?.toInt(),
);

Map<String, dynamic> _$$OccupationModelImplToJson(
  _$OccupationModelImpl instance,
) => <String, dynamic>{
  'occupation': instance.occupation,
  'occupation_details': instance.occupationDetails,
  'monthly_income': instance.monthlyIncome,
};
