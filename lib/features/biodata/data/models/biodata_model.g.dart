// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biodata_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BiodataModelImpl _$$BiodataModelImplFromJson(
  Map<String, dynamic> json,
) => _$BiodataModelImpl(
  id: json['_id'] as String,
  userId: json['user'] as String,
  userIdNumber: (json['user_id'] as num?)?.toInt(),
  bioType: json['bio_type'] as String,
  dateOfBirth: json['date_of_birth'] as String,
  height: (json['height'] as num).toDouble(),
  gender: json['gender'] as String,
  weight: (json['weight'] as num).toDouble(),
  bloodGroup: json['blood_group'] as String,
  screenColor: json['screen_color'] as String,
  nationality: json['nationality'] as String,
  maritalStatus: json['marital_status'] as String,
  religion: json['religion'] as String?,
  religiousType: json['religious_type'] as String?,
  upzilla: json['upzilla'] as String?,
  zilla: json['zilla'] as String?,
  viewsCount: (json['views_count'] as num?)?.toInt(),
  likesCount: (json['likes_count'] as num?)?.toInt(),
  dislikesCount: (json['dislikes_count'] as num?)?.toInt(),
  purchasesCount: (json['purchases_count'] as num?)?.toInt(),
  isFeatured: json['isFeatured'] as bool?,
  isMarriageDone: json['isMarriageDone'] as bool?,
  requestPracticingStatus: json['request_practicing_status'] as bool?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  address: json['address'] == null
      ? null
      : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
  educationQualification: json['educationQualification'] == null
      ? null
      : EducationModel.fromJson(
          json['educationQualification'] as Map<String, dynamic>,
        ),
  personalInfo: json['personalInfo'] == null
      ? null
      : PersonalInfoModel.fromJson(
          json['personalInfo'] as Map<String, dynamic>,
        ),
  familyStatus: json['familyStatus'] == null
      ? null
      : FamilyStatusModel.fromJson(
          json['familyStatus'] as Map<String, dynamic>,
        ),
  occupation: json['occupation'] == null
      ? null
      : OccupationModel.fromJson(json['occupation'] as Map<String, dynamic>),
  maritalInfo: json['maritalInfo'] == null
      ? null
      : MaritalInfoModel.fromJson(json['maritalInfo'] as Map<String, dynamic>),
  expectedLifePartner: json['expectedLifePartner'] == null
      ? null
      : ExpectedPartnerModel.fromJson(
          json['expectedLifePartner'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$BiodataModelImplToJson(_$BiodataModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.userId,
      'user_id': instance.userIdNumber,
      'bio_type': instance.bioType,
      'date_of_birth': instance.dateOfBirth,
      'height': instance.height,
      'gender': instance.gender,
      'weight': instance.weight,
      'blood_group': instance.bloodGroup,
      'screen_color': instance.screenColor,
      'nationality': instance.nationality,
      'marital_status': instance.maritalStatus,
      'religion': instance.religion,
      'religious_type': instance.religiousType,
      'upzilla': instance.upzilla,
      'zilla': instance.zilla,
      'views_count': instance.viewsCount,
      'likes_count': instance.likesCount,
      'dislikes_count': instance.dislikesCount,
      'purchases_count': instance.purchasesCount,
      'isFeatured': instance.isFeatured,
      'isMarriageDone': instance.isMarriageDone,
      'request_practicing_status': instance.requestPracticingStatus,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'address': instance.address,
      'educationQualification': instance.educationQualification,
      'personalInfo': instance.personalInfo,
      'familyStatus': instance.familyStatus,
      'occupation': instance.occupation,
      'maritalInfo': instance.maritalInfo,
      'expectedLifePartner': instance.expectedLifePartner,
    };
