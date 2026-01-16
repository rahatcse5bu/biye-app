class MaritalInfoEditModel {
  final String? id;
  final String? userId;
  final String? isFamilyAgree;
  final String? isPordaToWife;
  final String? permissionForStudy;
  final String? permissionForJob;
  final String? isJoutuk;
  final String? afterMarriageWhere;
  final String? divorcedReason;
  final String? whyMarriage;
  final String? wifeDeadInfo;
  final String? whenHusbandDead;
  final String? whyMarriedAnother;
  final String? isRunningJob;
  final String? isRunningStudy;
  final String? afterMarriageRunningJob;
  final String? quantityWifeAndChildren;

  MaritalInfoEditModel({
    this.id,
    this.userId,
    this.isFamilyAgree,
    this.isPordaToWife,
    this.permissionForStudy,
    this.permissionForJob,
    this.isJoutuk,
    this.afterMarriageWhere,
    this.divorcedReason,
    this.whyMarriage,
    this.wifeDeadInfo,
    this.whenHusbandDead,
    this.whyMarriedAnother,
    this.isRunningJob,
    this.isRunningStudy,
    this.afterMarriageRunningJob,
    this.quantityWifeAndChildren,
  });

  factory MaritalInfoEditModel.fromJson(Map<String, dynamic> json) {
    return MaritalInfoEditModel(
      id: json['_id']?.toString(),
      userId: json['user']?.toString(),
      isFamilyAgree: json['isFamilyAgree']?.toString(),
      isPordaToWife: json['isPordaToWife']?.toString(),
      permissionForStudy: json['permission_for_study']?.toString(),
      permissionForJob: json['permission_for_job']?.toString(),
      isJoutuk: json['isJoutuk']?.toString(),
      afterMarriageWhere: json['after_marriage_where']?.toString(),
      divorcedReason: json['divorced_reason']?.toString(),
      whyMarriage: json['why_marriage']?.toString(),
      wifeDeadInfo: json['wife_dead_info']?.toString(),
      whenHusbandDead: json['when_husband_dead']?.toString(),
      whyMarriedAnother: json['why_married_another']?.toString(),
      isRunningJob: json['is_running_job']?.toString(),
      isRunningStudy: json['is_running_study']?.toString(),
      afterMarriageRunningJob: json['after_marriage_running_job']?.toString(),
      quantityWifeAndChildren: json['quantity_wife_and_children']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user': userId,
      if (isFamilyAgree != null) 'isFamilyAgree': isFamilyAgree,
      if (isPordaToWife != null) 'isPordaToWife': isPordaToWife,
      if (permissionForStudy != null) 'permission_for_study': permissionForStudy,
      if (permissionForJob != null) 'permission_for_job': permissionForJob,
      if (isJoutuk != null) 'isJoutuk': isJoutuk,
      if (afterMarriageWhere != null) 'after_marriage_where': afterMarriageWhere,
      if (divorcedReason != null) 'divorced_reason': divorcedReason,
      if (whyMarriage != null) 'why_marriage': whyMarriage,
      if (wifeDeadInfo != null) 'wife_dead_info': wifeDeadInfo,
      if (whenHusbandDead != null) 'when_husband_dead': whenHusbandDead,
      if (whyMarriedAnother != null) 'why_married_another': whyMarriedAnother,
      if (isRunningJob != null) 'is_running_job': isRunningJob,
      if (isRunningStudy != null) 'is_running_study': isRunningStudy,
      if (afterMarriageRunningJob != null)
        'after_marriage_running_job': afterMarriageRunningJob,
      if (quantityWifeAndChildren != null)
        'quantity_wife_and_children': quantityWifeAndChildren,
    };
  }

  static MaritalInfoEditModel empty() {
    return MaritalInfoEditModel();
  }
}
