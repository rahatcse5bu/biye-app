import 'package:freezed_annotation/freezed_annotation.dart';

part 'marital_info_entity.freezed.dart';

@freezed
class MaritalInfoEntity with _$MaritalInfoEntity {
  const factory MaritalInfoEntity({
    String? isFamilyAgree,
    String? isPordaToWife,
    String? permissionForStudy,
    String? permissionForJob,
    String? isJoutuk,
    String? afterMarriageWhere,
    String? divorcedReason,
    String? whyMarriage,
    String? wifeDeadInfo,
    String? whenHusbandDead,
    String? whyMarriedAnother,
    String? isRunningJob,
    String? isRunningStudy,
    String? afterMarriageRunningJob,
    String? quantityWifeAndChildren,
  }) = _MaritalInfoEntity;
}
