import 'package:freezed_annotation/freezed_annotation.dart';

part 'education_entity.freezed.dart';

@freezed
class EducationEntity with _$EducationEntity {
  const factory EducationEntity({
    String? educationMedium,
    String? highestEduLevel,
    String? othersEdu,
    List<String>? deeniEdu,
    int? sscYear,
    String? sscGroup,
    String? sscResult,
    String? diplomaSub,
    String? diplomaInst,
    int? diplomaPassYear,
  }) = _EducationEntity;
}
