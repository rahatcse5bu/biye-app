import 'package:freezed_annotation/freezed_annotation.dart';

part 'expected_partner_entity.freezed.dart';

@freezed
class ExpectedPartnerEntity with _$ExpectedPartnerEntity {
  const factory ExpectedPartnerEntity({
    AgeRange? age,
    List<String>? color,
    HeightRange? height,
    List<String>? educationalQualifications,
    List<String>? zilla,
    List<String>? maritalStatus,
    List<String>? occupation,
    List<String>? economicalCondition,
    String? expectedCharacteristics,
  }) = _ExpectedPartnerEntity;
}

@freezed
class AgeRange with _$AgeRange {
  const factory AgeRange({
    int? min,
    int? max,
  }) = _AgeRange;
}

@freezed
class HeightRange with _$HeightRange {
  const factory HeightRange({
    double? min,
    double? max,
  }) = _HeightRange;
}
