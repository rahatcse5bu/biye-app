import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/education_entity.dart';

part 'education_model.freezed.dart';
part 'education_model.g.dart';

@freezed
class EducationModel with _$EducationModel {
  const EducationModel._();
  
  const factory EducationModel({
    @JsonKey(name: 'education_medium') String? educationMedium,
    @JsonKey(name: 'highest_edu_level') String? highestEduLevel,
    @JsonKey(name: 'others_edu') String? othersEdu,
    @JsonKey(name: 'deeni_edu') List<String>? deeniEdu,
    @JsonKey(name: 'ssc_year') int? sscYear,
    @JsonKey(name: 'ssc_group') String? sscGroup,
    @JsonKey(name: 'ssc_result') String? sscResult,
    @JsonKey(name: 'diploma_sub') String? diplomaSub,
    @JsonKey(name: 'diploma_inst') String? diplomaInst,
    @JsonKey(name: 'diploma_pass_year') int? diplomaPassYear,
  }) = _EducationModel;
  
  factory EducationModel.fromJson(Map<String, dynamic> json) =>
      _$EducationModelFromJson(json);
  
  EducationEntity toEntity() {
    return EducationEntity(
      educationMedium: educationMedium,
      highestEduLevel: highestEduLevel,
      othersEdu: othersEdu,
      deeniEdu: deeniEdu,
      sscYear: sscYear,
      sscGroup: sscGroup,
      sscResult: sscResult,
      diplomaSub: diplomaSub,
      diplomaInst: diplomaInst,
      diplomaPassYear: diplomaPassYear,
    );
  }
}
