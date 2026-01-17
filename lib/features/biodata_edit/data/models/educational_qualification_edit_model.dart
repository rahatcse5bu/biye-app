class EducationalQualificationEditModel {
  final String? id;
  final String? userId;
  final String? educationMedium;
  final String? highestEduLevel;
  final String? othersEdu;
  final String? beforeSsc;
  final List<String> deeniEdu;
  final int? sscYear;
  final String? sscGroup;
  final String? sscResult;
  final bool? afterSscRunning;
  final String? afterSscResult;
  final String? afterSscGroup;
  final int? afterSscYear;
  final String? diplomaRunningYear;
  final String? diplomaSub;
  final String? diplomaInst;
  final int? diplomaPassYear;
  final String? honsInst;
  final String? honsYear;
  final String? honsSub;
  final String? afterSscMedium;
  final int? honsPassYear;
  final String? mscSub;
  final int? mscPassYear;
  final String? mscInst;
  final int? phdPassYear;
  final String? phdInst;
  final String? phdSub;
  final String? ibtiResult;
  final int? ibtiPassYear;
  final String? ibtiInst;
  final String? mutawasInst;
  final int? mutawasPassYear;
  final String? mutawasResult;
  final String? sanabiyaInst;
  final String? sanabiyaResult;
  final int? sanabiyaPassYear;
  final String? fozilatInst;
  final String? fozilatResult;
  final int? fozilatPassYear;
  final String? takmilInst;
  final String? takmilResult;
  final int? takmilPassYear;
  final String? takhassusInst;
  final String? takhassusResult;
  final String? takhasssSub;
  final int? takhassusPassYear;
  final String? status;

  EducationalQualificationEditModel({
    this.id,
    this.userId,
    this.educationMedium,
    this.highestEduLevel,
    this.othersEdu,
    this.beforeSsc,
    this.deeniEdu = const [],
    this.sscYear,
    this.sscGroup,
    this.sscResult,
    this.afterSscRunning,
    this.afterSscResult,
    this.afterSscGroup,
    this.afterSscYear,
    this.diplomaRunningYear,
    this.diplomaSub,
    this.diplomaInst,
    this.diplomaPassYear,
    this.honsInst,
    this.honsYear,
    this.honsSub,
    this.afterSscMedium,
    this.honsPassYear,
    this.mscSub,
    this.mscPassYear,
    this.mscInst,
    this.phdPassYear,
    this.phdInst,
    this.phdSub,
    this.ibtiResult,
    this.ibtiPassYear,
    this.ibtiInst,
    this.mutawasInst,
    this.mutawasPassYear,
    this.mutawasResult,
    this.sanabiyaInst,
    this.sanabiyaResult,
    this.sanabiyaPassYear,
    this.fozilatInst,
    this.fozilatResult,
    this.fozilatPassYear,
    this.takmilInst,
    this.takmilResult,
    this.takmilPassYear,
    this.takhassusInst,
    this.takhassusResult,
    this.takhasssSub,
    this.takhassusPassYear,
    this.status,
  });

  factory EducationalQualificationEditModel.fromJson(Map<String, dynamic> json) {
    return EducationalQualificationEditModel(
      id: json['_id']?.toString(),
      userId: json['user']?.toString(),
      educationMedium: json['education_medium']?.toString(),
      highestEduLevel: json['highest_edu_level']?.toString(),
      othersEdu: json['others_edu']?.toString(),
      beforeSsc: json['before_ssc']?.toString(),
      deeniEdu: json['deeni_edu'] != null
          ? List<String>.from(json['deeni_edu'].map((x) => x.toString()))
          : [],
      sscYear: _toInt(json['ssc_year']),
      sscGroup: json['ssc_group']?.toString(),
      sscResult: json['ssc_result']?.toString(),
      afterSscRunning: json['after_ssc_running'],
      afterSscResult: json['after_ssc_result']?.toString(),
      afterSscGroup: json['after_ssc_group']?.toString(),
      afterSscYear: _toInt(json['after_ssc_year']),
      diplomaRunningYear: json['diploma_running_year']?.toString(),
      diplomaSub: json['diploma_sub']?.toString(),
      diplomaInst: json['diploma_inst']?.toString(),
      diplomaPassYear: _toInt(json['diploma_pass_year']),
      honsInst: json['hons_inst']?.toString(),
      honsYear: json['hons_year']?.toString(),
      honsSub: json['hons_sub']?.toString(),
      afterSscMedium: json['after_ssc_medium']?.toString(),
      honsPassYear: _toInt(json['hons_pass_year']),
      mscSub: json['msc_sub']?.toString(),
      mscPassYear: _toInt(json['msc_pass_year']),
      mscInst: json['msc_inst']?.toString(),
      phdPassYear: _toInt(json['phd_pass_year']),
      phdInst: json['phd_inst']?.toString(),
      phdSub: json['phd_sub']?.toString(),
      ibtiResult: json['ibti_result']?.toString(),
      ibtiPassYear: _toInt(json['ibti_pass_year']),
      ibtiInst: json['ibti_inst']?.toString(),
      mutawasInst: json['mutawas_inst']?.toString(),
      mutawasPassYear: _toInt(json['mutawas_pass_year']),
      mutawasResult: json['mutawas_result']?.toString(),
      sanabiyaInst: json['sanabiya_inst']?.toString(),
      sanabiyaResult: json['sanabiya_result']?.toString(),
      sanabiyaPassYear: _toInt(json['sanabiya_pass_year']),
      fozilatInst: json['fozilat_inst']?.toString(),
      fozilatResult: json['fozilat_result']?.toString(),
      fozilatPassYear: _toInt(json['fozilat_pass_year']),
      takmilInst: json['takmil_inst']?.toString(),
      takmilResult: json['takmil_result']?.toString(),
      takmilPassYear: _toInt(json['takmil_pass_year']),
      takhassusInst: json['takhassus_inst']?.toString(),
      takhassusResult: json['takhassus_result']?.toString(),
      takhasssSub: json['takhassus_sub']?.toString(),
      takhassusPassYear: _toInt(json['takhassus_pass_year']),
      status: json['status']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user': userId,
      'user_form': 2, // Step 2 - Educational Qualification
      if (educationMedium != null) 'education_medium': educationMedium,
      if (highestEduLevel != null) 'highest_edu_level': highestEduLevel,
      if (othersEdu != null) 'others_edu': othersEdu,
      if (beforeSsc != null) 'before_ssc': beforeSsc,
      'deeni_edu': deeniEdu,
      if (sscYear != null) 'ssc_year': sscYear,
      if (sscGroup != null) 'ssc_group': sscGroup,
      if (sscResult != null) 'ssc_result': sscResult,
      if (afterSscRunning != null) 'after_ssc_running': afterSscRunning,
      if (afterSscResult != null) 'after_ssc_result': afterSscResult,
      if (afterSscGroup != null) 'after_ssc_group': afterSscGroup,
      if (afterSscYear != null) 'after_ssc_year': afterSscYear,
      if (diplomaRunningYear != null) 'diploma_running_year': diplomaRunningYear,
      if (diplomaSub != null) 'diploma_sub': diplomaSub,
      if (diplomaInst != null) 'diploma_inst': diplomaInst,
      if (diplomaPassYear != null) 'diploma_pass_year': diplomaPassYear,
      if (honsInst != null) 'hons_inst': honsInst,
      if (honsYear != null) 'hons_year': honsYear,
      if (honsSub != null) 'hons_sub': honsSub,
      if (afterSscMedium != null) 'after_ssc_medium': afterSscMedium,
      if (honsPassYear != null) 'hons_pass_year': honsPassYear,
      if (mscSub != null) 'msc_sub': mscSub,
      if (mscPassYear != null) 'msc_pass_year': mscPassYear,
      if (mscInst != null) 'msc_inst': mscInst,
      if (phdPassYear != null) 'phd_pass_year': phdPassYear,
      if (phdInst != null) 'phd_inst': phdInst,
      if (phdSub != null) 'phd_sub': phdSub,
      if (ibtiResult != null) 'ibti_result': ibtiResult,
      if (ibtiPassYear != null) 'ibti_pass_year': ibtiPassYear,
      if (ibtiInst != null) 'ibti_inst': ibtiInst,
      if (mutawasInst != null) 'mutawas_inst': mutawasInst,
      if (mutawasPassYear != null) 'mutawas_pass_year': mutawasPassYear,
      if (mutawasResult != null) 'mutawas_result': mutawasResult,
      if (sanabiyaInst != null) 'sanabiya_inst': sanabiyaInst,
      if (sanabiyaResult != null) 'sanabiya_result': sanabiyaResult,
      if (sanabiyaPassYear != null) 'sanabiya_pass_year': sanabiyaPassYear,
      if (fozilatInst != null) 'fozilat_inst': fozilatInst,
      if (fozilatResult != null) 'fozilat_result': fozilatResult,
      if (fozilatPassYear != null) 'fozilat_pass_year': fozilatPassYear,
      if (takmilInst != null) 'takmil_inst': takmilInst,
      if (takmilResult != null) 'takmil_result': takmilResult,
      if (takmilPassYear != null) 'takmil_pass_year': takmilPassYear,
      if (takhassusInst != null) 'takhassus_inst': takhassusInst,
      if (takhassusResult != null) 'takhassus_result': takhassusResult,
      if (takhasssSub != null) 'takhassus_sub': takhasssSub,
      if (takhassusPassYear != null) 'takhassus_pass_year': takhassusPassYear,
      if (status != null) 'status': status,
    };
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static EducationalQualificationEditModel empty() {
    return EducationalQualificationEditModel();
  }
}
