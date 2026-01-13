// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressModelImpl _$$AddressModelImplFromJson(Map<String, dynamic> json) =>
    _$AddressModelImpl(
      permanentAddress: json['permanent_address'] as String?,
      presentAddress: json['present_address'] as String?,
      grownUp: json['grown_up'] as String?,
      presentArea: json['present_area'] as String?,
      permanentArea: json['permanent_area'] as String?,
      zilla: json['zilla'] as String?,
      upzilla: json['upzilla'] as String?,
      division: json['division'] as String?,
      presentZilla: json['present_zilla'] as String?,
      presentUpzilla: json['present_upzilla'] as String?,
      presentDivision: json['present_division'] as String?,
      city: json['city'] as String?,
      zip: (json['zip'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AddressModelImplToJson(_$AddressModelImpl instance) =>
    <String, dynamic>{
      'permanent_address': instance.permanentAddress,
      'present_address': instance.presentAddress,
      'grown_up': instance.grownUp,
      'present_area': instance.presentArea,
      'permanent_area': instance.permanentArea,
      'zilla': instance.zilla,
      'upzilla': instance.upzilla,
      'division': instance.division,
      'present_zilla': instance.presentZilla,
      'present_upzilla': instance.presentUpzilla,
      'present_division': instance.presentDivision,
      'city': instance.city,
      'zip': instance.zip,
    };
