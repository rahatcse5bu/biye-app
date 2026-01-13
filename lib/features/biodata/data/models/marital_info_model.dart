import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/marital_info_entity.dart';

part 'marital_info_model.freezed.dart';
part 'marital_info_model.g.dart';

@freezed
class MaritalInfoModel with _$MaritalInfoModel {
  const MaritalInfoModel._();
  
  const factory MaritalInfoModel({
    @JsonKey(name: 'isFamilyAgree') String? isFamilyAgree,
    @JsonKey(name: 'isPordaToWife') String? isPordaToWife,
    @JsonKey(name: 'permission_for_study') String? permissionForStudy,
    @JsonKey(name: 'permission_for_job') String? permissionForJob,
    @JsonKey(name: 'isJoutuk') String? isJoutuk,
    @JsonKey(name: 'after_marriage_where') String? afterMarriageWhere,
    @JsonKey(name: 'divorced_reason') String? divorcedReason,
    @JsonKey(name: 'why_marriage') String? whyMarriage,
    @JsonKey(name: 'wife_dead_info') String? wifeDeadInfo,
    @JsonKey(name: 'when_husband_dead') String? whenHusbandDead,
    @JsonKey(name: 'why_married_another') String? whyMarriedAnother,
    @JsonKey(name: 'is_running_job') String? isRunningJob,
    @JsonKey(name: 'is_running_study') String? isRunningStudy,
    @JsonKey(name: 'after_marriage_running_job') String? afterMarriageRunningJob,
    @JsonKey(name: 'quantity_wife_and_children') String? quantityWifeAndChildren,
  }) = _MaritalInfoModel;
  
  factory MaritalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$MaritalInfoModelFromJson(json);
  
  MaritalInfoEntity toEntity() {
    return MaritalInfoEntity(
      isFamilyAgree: isFamilyAgree,
      isPordaToWife: isPordaToWife,
      permissionForStudy: permissionForStudy,
      permissionForJob: permissionForJob,
      isJoutuk: isJoutuk,
      afterMarriageWhere: afterMarriageWhere,
      divorcedReason: divorcedReason,
      whyMarriage: whyMarriage,
      wifeDeadInfo: wifeDeadInfo,
      whenHusbandDead: whenHusbandDead,
      whyMarriedAnother: whyMarriedAnother,
      isRunningJob: isRunningJob,
      isRunningStudy: isRunningStudy,
      afterMarriageRunningJob: afterMarriageRunningJob,
      quantityWifeAndChildren: quantityWifeAndChildren,
    );
  }
}
