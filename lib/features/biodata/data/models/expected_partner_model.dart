import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/expected_partner_entity.dart';

part 'expected_partner_model.freezed.dart';
part 'expected_partner_model.g.dart';

@freezed
class ExpectedPartnerModel with _$ExpectedPartnerModel {
  const ExpectedPartnerModel._();
  
  const factory ExpectedPartnerModel({
    AgeRangeModel? age,
    List<String>? color,
    HeightRangeModel? height,
    @JsonKey(name: 'educational_qualifications') List<String>? educationalQualifications,
    List<String>? zilla,
    @JsonKey(name: 'marital_status') List<String>? maritalStatus,
    List<String>? occupation,
    @JsonKey(name: 'economical_condition') List<String>? economicalCondition,
    @JsonKey(name: 'expected_characteristics') String? expectedCharacteristics,
  }) = _ExpectedPartnerModel;
  
  factory ExpectedPartnerModel.fromJson(Map<String, dynamic> json) =>
      _$ExpectedPartnerModelFromJson(json);
  
  ExpectedPartnerEntity toEntity() {
    return ExpectedPartnerEntity(
      age: age?.toEntity(),
      color: color,
      height: height?.toEntity(),
      educationalQualifications: educationalQualifications,
      zilla: zilla,
      maritalStatus: maritalStatus,
      occupation: occupation,
      economicalCondition: economicalCondition,
      expectedCharacteristics: expectedCharacteristics,
    );
  }
}

@freezed
class AgeRangeModel with _$AgeRangeModel {
  const AgeRangeModel._();
  
  const factory AgeRangeModel({
    int? min,
    int? max,
  }) = _AgeRangeModel;
  
  factory AgeRangeModel.fromJson(Map<String, dynamic> json) =>
      _$AgeRangeModelFromJson(json);
  
  AgeRange toEntity() {
    return AgeRange(min: min, max: max);
  }
}

@freezed
class HeightRangeModel with _$HeightRangeModel {
  const HeightRangeModel._();
  
  const factory HeightRangeModel({
    double? min,
    double? max,
  }) = _HeightRangeModel;
  
  factory HeightRangeModel.fromJson(Map<String, dynamic> json) =>
      _$HeightRangeModelFromJson(json);
  
  HeightRange toEntity() {
    return HeightRange(min: min, max: max);
  }
}
