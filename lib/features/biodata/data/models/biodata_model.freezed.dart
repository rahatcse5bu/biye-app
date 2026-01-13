// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biodata_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BiodataModel _$BiodataModelFromJson(Map<String, dynamic> json) {
  return _BiodataModel.fromJson(json);
}

/// @nodoc
mixin _$BiodataModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int? get userIdNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'bio_type')
  String get bioType => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_of_birth')
  String get dateOfBirth => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;
  @JsonKey(name: 'blood_group')
  String get bloodGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'screen_color')
  String get screenColor => throw _privateConstructorUsedError;
  String get nationality => throw _privateConstructorUsedError;
  @JsonKey(name: 'marital_status')
  String get maritalStatus => throw _privateConstructorUsedError;
  String? get upzilla => throw _privateConstructorUsedError;
  String? get zilla => throw _privateConstructorUsedError;
  @JsonKey(name: 'views_count')
  int? get viewsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'likes_count')
  int? get likesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'dislikes_count')
  int? get dislikesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchases_count')
  int? get purchasesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'isFeatured')
  bool? get isFeatured => throw _privateConstructorUsedError;
  @JsonKey(name: 'isMarriageDone')
  bool? get isMarriageDone => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedAt')
  String? get updatedAt => throw _privateConstructorUsedError;
  AddressModel? get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'educationQualification')
  EducationModel? get educationQualification =>
      throw _privateConstructorUsedError;
  PersonalInfoModel? get personalInfo => throw _privateConstructorUsedError;
  FamilyStatusModel? get familyStatus => throw _privateConstructorUsedError;
  OccupationModel? get occupation => throw _privateConstructorUsedError;
  MaritalInfoModel? get maritalInfo => throw _privateConstructorUsedError;
  ExpectedPartnerModel? get expectedLifePartner =>
      throw _privateConstructorUsedError;

  /// Serializes this BiodataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BiodataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BiodataModelCopyWith<BiodataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BiodataModelCopyWith<$Res> {
  factory $BiodataModelCopyWith(
    BiodataModel value,
    $Res Function(BiodataModel) then,
  ) = _$BiodataModelCopyWithImpl<$Res, BiodataModel>;
  @useResult
  $Res call({
    @JsonKey(name: '_id') String id,
    @JsonKey(name: 'user') String userId,
    @JsonKey(name: 'user_id') int? userIdNumber,
    @JsonKey(name: 'bio_type') String bioType,
    @JsonKey(name: 'date_of_birth') String dateOfBirth,
    double height,
    String gender,
    double weight,
    @JsonKey(name: 'blood_group') String bloodGroup,
    @JsonKey(name: 'screen_color') String screenColor,
    String nationality,
    @JsonKey(name: 'marital_status') String maritalStatus,
    String? upzilla,
    String? zilla,
    @JsonKey(name: 'views_count') int? viewsCount,
    @JsonKey(name: 'likes_count') int? likesCount,
    @JsonKey(name: 'dislikes_count') int? dislikesCount,
    @JsonKey(name: 'purchases_count') int? purchasesCount,
    @JsonKey(name: 'isFeatured') bool? isFeatured,
    @JsonKey(name: 'isMarriageDone') bool? isMarriageDone,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'updatedAt') String? updatedAt,
    AddressModel? address,
    @JsonKey(name: 'educationQualification')
    EducationModel? educationQualification,
    PersonalInfoModel? personalInfo,
    FamilyStatusModel? familyStatus,
    OccupationModel? occupation,
    MaritalInfoModel? maritalInfo,
    ExpectedPartnerModel? expectedLifePartner,
  });

  $AddressModelCopyWith<$Res>? get address;
  $EducationModelCopyWith<$Res>? get educationQualification;
  $PersonalInfoModelCopyWith<$Res>? get personalInfo;
  $FamilyStatusModelCopyWith<$Res>? get familyStatus;
  $OccupationModelCopyWith<$Res>? get occupation;
  $MaritalInfoModelCopyWith<$Res>? get maritalInfo;
  $ExpectedPartnerModelCopyWith<$Res>? get expectedLifePartner;
}

/// @nodoc
class _$BiodataModelCopyWithImpl<$Res, $Val extends BiodataModel>
    implements $BiodataModelCopyWith<$Res> {
  _$BiodataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BiodataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userIdNumber = freezed,
    Object? bioType = null,
    Object? dateOfBirth = null,
    Object? height = null,
    Object? gender = null,
    Object? weight = null,
    Object? bloodGroup = null,
    Object? screenColor = null,
    Object? nationality = null,
    Object? maritalStatus = null,
    Object? upzilla = freezed,
    Object? zilla = freezed,
    Object? viewsCount = freezed,
    Object? likesCount = freezed,
    Object? dislikesCount = freezed,
    Object? purchasesCount = freezed,
    Object? isFeatured = freezed,
    Object? isMarriageDone = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? address = freezed,
    Object? educationQualification = freezed,
    Object? personalInfo = freezed,
    Object? familyStatus = freezed,
    Object? occupation = freezed,
    Object? maritalInfo = freezed,
    Object? expectedLifePartner = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            userIdNumber: freezed == userIdNumber
                ? _value.userIdNumber
                : userIdNumber // ignore: cast_nullable_to_non_nullable
                      as int?,
            bioType: null == bioType
                ? _value.bioType
                : bioType // ignore: cast_nullable_to_non_nullable
                      as String,
            dateOfBirth: null == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                      as String,
            height: null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as double,
            gender: null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String,
            weight: null == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as double,
            bloodGroup: null == bloodGroup
                ? _value.bloodGroup
                : bloodGroup // ignore: cast_nullable_to_non_nullable
                      as String,
            screenColor: null == screenColor
                ? _value.screenColor
                : screenColor // ignore: cast_nullable_to_non_nullable
                      as String,
            nationality: null == nationality
                ? _value.nationality
                : nationality // ignore: cast_nullable_to_non_nullable
                      as String,
            maritalStatus: null == maritalStatus
                ? _value.maritalStatus
                : maritalStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            upzilla: freezed == upzilla
                ? _value.upzilla
                : upzilla // ignore: cast_nullable_to_non_nullable
                      as String?,
            zilla: freezed == zilla
                ? _value.zilla
                : zilla // ignore: cast_nullable_to_non_nullable
                      as String?,
            viewsCount: freezed == viewsCount
                ? _value.viewsCount
                : viewsCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            likesCount: freezed == likesCount
                ? _value.likesCount
                : likesCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            dislikesCount: freezed == dislikesCount
                ? _value.dislikesCount
                : dislikesCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            purchasesCount: freezed == purchasesCount
                ? _value.purchasesCount
                : purchasesCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            isFeatured: freezed == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool?,
            isMarriageDone: freezed == isMarriageDone
                ? _value.isMarriageDone
                : isMarriageDone // ignore: cast_nullable_to_non_nullable
                      as bool?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as AddressModel?,
            educationQualification: freezed == educationQualification
                ? _value.educationQualification
                : educationQualification // ignore: cast_nullable_to_non_nullable
                      as EducationModel?,
            personalInfo: freezed == personalInfo
                ? _value.personalInfo
                : personalInfo // ignore: cast_nullable_to_non_nullable
                      as PersonalInfoModel?,
            familyStatus: freezed == familyStatus
                ? _value.familyStatus
                : familyStatus // ignore: cast_nullable_to_non_nullable
                      as FamilyStatusModel?,
            occupation: freezed == occupation
                ? _value.occupation
                : occupation // ignore: cast_nullable_to_non_nullable
                      as OccupationModel?,
            maritalInfo: freezed == maritalInfo
                ? _value.maritalInfo
                : maritalInfo // ignore: cast_nullable_to_non_nullable
                      as MaritalInfoModel?,
            expectedLifePartner: freezed == expectedLifePartner
                ? _value.expectedLifePartner
                : expectedLifePartner // ignore: cast_nullable_to_non_nullable
                      as ExpectedPartnerModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of BiodataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressModelCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressModelCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  /// Create a copy of BiodataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EducationModelCopyWith<$Res>? get educationQualification {
    if (_value.educationQualification == null) {
      return null;
    }

    return $EducationModelCopyWith<$Res>(_value.educationQualification!, (
      value,
    ) {
      return _then(_value.copyWith(educationQualification: value) as $Val);
    });
  }

  /// Create a copy of BiodataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PersonalInfoModelCopyWith<$Res>? get personalInfo {
    if (_value.personalInfo == null) {
      return null;
    }

    return $PersonalInfoModelCopyWith<$Res>(_value.personalInfo!, (value) {
      return _then(_value.copyWith(personalInfo: value) as $Val);
    });
  }

  /// Create a copy of BiodataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FamilyStatusModelCopyWith<$Res>? get familyStatus {
    if (_value.familyStatus == null) {
      return null;
    }

    return $FamilyStatusModelCopyWith<$Res>(_value.familyStatus!, (value) {
      return _then(_value.copyWith(familyStatus: value) as $Val);
    });
  }

  /// Create a copy of BiodataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OccupationModelCopyWith<$Res>? get occupation {
    if (_value.occupation == null) {
      return null;
    }

    return $OccupationModelCopyWith<$Res>(_value.occupation!, (value) {
      return _then(_value.copyWith(occupation: value) as $Val);
    });
  }

  /// Create a copy of BiodataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MaritalInfoModelCopyWith<$Res>? get maritalInfo {
    if (_value.maritalInfo == null) {
      return null;
    }

    return $MaritalInfoModelCopyWith<$Res>(_value.maritalInfo!, (value) {
      return _then(_value.copyWith(maritalInfo: value) as $Val);
    });
  }

  /// Create a copy of BiodataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExpectedPartnerModelCopyWith<$Res>? get expectedLifePartner {
    if (_value.expectedLifePartner == null) {
      return null;
    }

    return $ExpectedPartnerModelCopyWith<$Res>(_value.expectedLifePartner!, (
      value,
    ) {
      return _then(_value.copyWith(expectedLifePartner: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BiodataModelImplCopyWith<$Res>
    implements $BiodataModelCopyWith<$Res> {
  factory _$$BiodataModelImplCopyWith(
    _$BiodataModelImpl value,
    $Res Function(_$BiodataModelImpl) then,
  ) = __$$BiodataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: '_id') String id,
    @JsonKey(name: 'user') String userId,
    @JsonKey(name: 'user_id') int? userIdNumber,
    @JsonKey(name: 'bio_type') String bioType,
    @JsonKey(name: 'date_of_birth') String dateOfBirth,
    double height,
    String gender,
    double weight,
    @JsonKey(name: 'blood_group') String bloodGroup,
    @JsonKey(name: 'screen_color') String screenColor,
    String nationality,
    @JsonKey(name: 'marital_status') String maritalStatus,
    String? upzilla,
    String? zilla,
    @JsonKey(name: 'views_count') int? viewsCount,
    @JsonKey(name: 'likes_count') int? likesCount,
    @JsonKey(name: 'dislikes_count') int? dislikesCount,
    @JsonKey(name: 'purchases_count') int? purchasesCount,
    @JsonKey(name: 'isFeatured') bool? isFeatured,
    @JsonKey(name: 'isMarriageDone') bool? isMarriageDone,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'updatedAt') String? updatedAt,
    AddressModel? address,
    @JsonKey(name: 'educationQualification')
    EducationModel? educationQualification,
    PersonalInfoModel? personalInfo,
    FamilyStatusModel? familyStatus,
    OccupationModel? occupation,
    MaritalInfoModel? maritalInfo,
    ExpectedPartnerModel? expectedLifePartner,
  });

  @override
  $AddressModelCopyWith<$Res>? get address;
  @override
  $EducationModelCopyWith<$Res>? get educationQualification;
  @override
  $PersonalInfoModelCopyWith<$Res>? get personalInfo;
  @override
  $FamilyStatusModelCopyWith<$Res>? get familyStatus;
  @override
  $OccupationModelCopyWith<$Res>? get occupation;
  @override
  $MaritalInfoModelCopyWith<$Res>? get maritalInfo;
  @override
  $ExpectedPartnerModelCopyWith<$Res>? get expectedLifePartner;
}

/// @nodoc
class __$$BiodataModelImplCopyWithImpl<$Res>
    extends _$BiodataModelCopyWithImpl<$Res, _$BiodataModelImpl>
    implements _$$BiodataModelImplCopyWith<$Res> {
  __$$BiodataModelImplCopyWithImpl(
    _$BiodataModelImpl _value,
    $Res Function(_$BiodataModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BiodataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userIdNumber = freezed,
    Object? bioType = null,
    Object? dateOfBirth = null,
    Object? height = null,
    Object? gender = null,
    Object? weight = null,
    Object? bloodGroup = null,
    Object? screenColor = null,
    Object? nationality = null,
    Object? maritalStatus = null,
    Object? upzilla = freezed,
    Object? zilla = freezed,
    Object? viewsCount = freezed,
    Object? likesCount = freezed,
    Object? dislikesCount = freezed,
    Object? purchasesCount = freezed,
    Object? isFeatured = freezed,
    Object? isMarriageDone = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? address = freezed,
    Object? educationQualification = freezed,
    Object? personalInfo = freezed,
    Object? familyStatus = freezed,
    Object? occupation = freezed,
    Object? maritalInfo = freezed,
    Object? expectedLifePartner = freezed,
  }) {
    return _then(
      _$BiodataModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        userIdNumber: freezed == userIdNumber
            ? _value.userIdNumber
            : userIdNumber // ignore: cast_nullable_to_non_nullable
                  as int?,
        bioType: null == bioType
            ? _value.bioType
            : bioType // ignore: cast_nullable_to_non_nullable
                  as String,
        dateOfBirth: null == dateOfBirth
            ? _value.dateOfBirth
            : dateOfBirth // ignore: cast_nullable_to_non_nullable
                  as String,
        height: null == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as double,
        gender: null == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String,
        weight: null == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double,
        bloodGroup: null == bloodGroup
            ? _value.bloodGroup
            : bloodGroup // ignore: cast_nullable_to_non_nullable
                  as String,
        screenColor: null == screenColor
            ? _value.screenColor
            : screenColor // ignore: cast_nullable_to_non_nullable
                  as String,
        nationality: null == nationality
            ? _value.nationality
            : nationality // ignore: cast_nullable_to_non_nullable
                  as String,
        maritalStatus: null == maritalStatus
            ? _value.maritalStatus
            : maritalStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        upzilla: freezed == upzilla
            ? _value.upzilla
            : upzilla // ignore: cast_nullable_to_non_nullable
                  as String?,
        zilla: freezed == zilla
            ? _value.zilla
            : zilla // ignore: cast_nullable_to_non_nullable
                  as String?,
        viewsCount: freezed == viewsCount
            ? _value.viewsCount
            : viewsCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        likesCount: freezed == likesCount
            ? _value.likesCount
            : likesCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        dislikesCount: freezed == dislikesCount
            ? _value.dislikesCount
            : dislikesCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        purchasesCount: freezed == purchasesCount
            ? _value.purchasesCount
            : purchasesCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        isFeatured: freezed == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool?,
        isMarriageDone: freezed == isMarriageDone
            ? _value.isMarriageDone
            : isMarriageDone // ignore: cast_nullable_to_non_nullable
                  as bool?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as AddressModel?,
        educationQualification: freezed == educationQualification
            ? _value.educationQualification
            : educationQualification // ignore: cast_nullable_to_non_nullable
                  as EducationModel?,
        personalInfo: freezed == personalInfo
            ? _value.personalInfo
            : personalInfo // ignore: cast_nullable_to_non_nullable
                  as PersonalInfoModel?,
        familyStatus: freezed == familyStatus
            ? _value.familyStatus
            : familyStatus // ignore: cast_nullable_to_non_nullable
                  as FamilyStatusModel?,
        occupation: freezed == occupation
            ? _value.occupation
            : occupation // ignore: cast_nullable_to_non_nullable
                  as OccupationModel?,
        maritalInfo: freezed == maritalInfo
            ? _value.maritalInfo
            : maritalInfo // ignore: cast_nullable_to_non_nullable
                  as MaritalInfoModel?,
        expectedLifePartner: freezed == expectedLifePartner
            ? _value.expectedLifePartner
            : expectedLifePartner // ignore: cast_nullable_to_non_nullable
                  as ExpectedPartnerModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BiodataModelImpl extends _BiodataModel {
  const _$BiodataModelImpl({
    @JsonKey(name: '_id') required this.id,
    @JsonKey(name: 'user') required this.userId,
    @JsonKey(name: 'user_id') this.userIdNumber,
    @JsonKey(name: 'bio_type') required this.bioType,
    @JsonKey(name: 'date_of_birth') required this.dateOfBirth,
    required this.height,
    required this.gender,
    required this.weight,
    @JsonKey(name: 'blood_group') required this.bloodGroup,
    @JsonKey(name: 'screen_color') required this.screenColor,
    required this.nationality,
    @JsonKey(name: 'marital_status') required this.maritalStatus,
    this.upzilla,
    this.zilla,
    @JsonKey(name: 'views_count') this.viewsCount,
    @JsonKey(name: 'likes_count') this.likesCount,
    @JsonKey(name: 'dislikes_count') this.dislikesCount,
    @JsonKey(name: 'purchases_count') this.purchasesCount,
    @JsonKey(name: 'isFeatured') this.isFeatured,
    @JsonKey(name: 'isMarriageDone') this.isMarriageDone,
    @JsonKey(name: 'createdAt') this.createdAt,
    @JsonKey(name: 'updatedAt') this.updatedAt,
    this.address,
    @JsonKey(name: 'educationQualification') this.educationQualification,
    this.personalInfo,
    this.familyStatus,
    this.occupation,
    this.maritalInfo,
    this.expectedLifePartner,
  }) : super._();

  factory _$BiodataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BiodataModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey(name: 'user')
  final String userId;
  @override
  @JsonKey(name: 'user_id')
  final int? userIdNumber;
  @override
  @JsonKey(name: 'bio_type')
  final String bioType;
  @override
  @JsonKey(name: 'date_of_birth')
  final String dateOfBirth;
  @override
  final double height;
  @override
  final String gender;
  @override
  final double weight;
  @override
  @JsonKey(name: 'blood_group')
  final String bloodGroup;
  @override
  @JsonKey(name: 'screen_color')
  final String screenColor;
  @override
  final String nationality;
  @override
  @JsonKey(name: 'marital_status')
  final String maritalStatus;
  @override
  final String? upzilla;
  @override
  final String? zilla;
  @override
  @JsonKey(name: 'views_count')
  final int? viewsCount;
  @override
  @JsonKey(name: 'likes_count')
  final int? likesCount;
  @override
  @JsonKey(name: 'dislikes_count')
  final int? dislikesCount;
  @override
  @JsonKey(name: 'purchases_count')
  final int? purchasesCount;
  @override
  @JsonKey(name: 'isFeatured')
  final bool? isFeatured;
  @override
  @JsonKey(name: 'isMarriageDone')
  final bool? isMarriageDone;
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @override
  final AddressModel? address;
  @override
  @JsonKey(name: 'educationQualification')
  final EducationModel? educationQualification;
  @override
  final PersonalInfoModel? personalInfo;
  @override
  final FamilyStatusModel? familyStatus;
  @override
  final OccupationModel? occupation;
  @override
  final MaritalInfoModel? maritalInfo;
  @override
  final ExpectedPartnerModel? expectedLifePartner;

  @override
  String toString() {
    return 'BiodataModel(id: $id, userId: $userId, userIdNumber: $userIdNumber, bioType: $bioType, dateOfBirth: $dateOfBirth, height: $height, gender: $gender, weight: $weight, bloodGroup: $bloodGroup, screenColor: $screenColor, nationality: $nationality, maritalStatus: $maritalStatus, upzilla: $upzilla, zilla: $zilla, viewsCount: $viewsCount, likesCount: $likesCount, dislikesCount: $dislikesCount, purchasesCount: $purchasesCount, isFeatured: $isFeatured, isMarriageDone: $isMarriageDone, createdAt: $createdAt, updatedAt: $updatedAt, address: $address, educationQualification: $educationQualification, personalInfo: $personalInfo, familyStatus: $familyStatus, occupation: $occupation, maritalInfo: $maritalInfo, expectedLifePartner: $expectedLifePartner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BiodataModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userIdNumber, userIdNumber) ||
                other.userIdNumber == userIdNumber) &&
            (identical(other.bioType, bioType) || other.bioType == bioType) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.bloodGroup, bloodGroup) ||
                other.bloodGroup == bloodGroup) &&
            (identical(other.screenColor, screenColor) ||
                other.screenColor == screenColor) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.maritalStatus, maritalStatus) ||
                other.maritalStatus == maritalStatus) &&
            (identical(other.upzilla, upzilla) || other.upzilla == upzilla) &&
            (identical(other.zilla, zilla) || other.zilla == zilla) &&
            (identical(other.viewsCount, viewsCount) ||
                other.viewsCount == viewsCount) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.dislikesCount, dislikesCount) ||
                other.dislikesCount == dislikesCount) &&
            (identical(other.purchasesCount, purchasesCount) ||
                other.purchasesCount == purchasesCount) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.isMarriageDone, isMarriageDone) ||
                other.isMarriageDone == isMarriageDone) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.educationQualification, educationQualification) ||
                other.educationQualification == educationQualification) &&
            (identical(other.personalInfo, personalInfo) ||
                other.personalInfo == personalInfo) &&
            (identical(other.familyStatus, familyStatus) ||
                other.familyStatus == familyStatus) &&
            (identical(other.occupation, occupation) ||
                other.occupation == occupation) &&
            (identical(other.maritalInfo, maritalInfo) ||
                other.maritalInfo == maritalInfo) &&
            (identical(other.expectedLifePartner, expectedLifePartner) ||
                other.expectedLifePartner == expectedLifePartner));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    userId,
    userIdNumber,
    bioType,
    dateOfBirth,
    height,
    gender,
    weight,
    bloodGroup,
    screenColor,
    nationality,
    maritalStatus,
    upzilla,
    zilla,
    viewsCount,
    likesCount,
    dislikesCount,
    purchasesCount,
    isFeatured,
    isMarriageDone,
    createdAt,
    updatedAt,
    address,
    educationQualification,
    personalInfo,
    familyStatus,
    occupation,
    maritalInfo,
    expectedLifePartner,
  ]);

  /// Create a copy of BiodataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BiodataModelImplCopyWith<_$BiodataModelImpl> get copyWith =>
      __$$BiodataModelImplCopyWithImpl<_$BiodataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BiodataModelImplToJson(this);
  }
}

abstract class _BiodataModel extends BiodataModel {
  const factory _BiodataModel({
    @JsonKey(name: '_id') required final String id,
    @JsonKey(name: 'user') required final String userId,
    @JsonKey(name: 'user_id') final int? userIdNumber,
    @JsonKey(name: 'bio_type') required final String bioType,
    @JsonKey(name: 'date_of_birth') required final String dateOfBirth,
    required final double height,
    required final String gender,
    required final double weight,
    @JsonKey(name: 'blood_group') required final String bloodGroup,
    @JsonKey(name: 'screen_color') required final String screenColor,
    required final String nationality,
    @JsonKey(name: 'marital_status') required final String maritalStatus,
    final String? upzilla,
    final String? zilla,
    @JsonKey(name: 'views_count') final int? viewsCount,
    @JsonKey(name: 'likes_count') final int? likesCount,
    @JsonKey(name: 'dislikes_count') final int? dislikesCount,
    @JsonKey(name: 'purchases_count') final int? purchasesCount,
    @JsonKey(name: 'isFeatured') final bool? isFeatured,
    @JsonKey(name: 'isMarriageDone') final bool? isMarriageDone,
    @JsonKey(name: 'createdAt') final String? createdAt,
    @JsonKey(name: 'updatedAt') final String? updatedAt,
    final AddressModel? address,
    @JsonKey(name: 'educationQualification')
    final EducationModel? educationQualification,
    final PersonalInfoModel? personalInfo,
    final FamilyStatusModel? familyStatus,
    final OccupationModel? occupation,
    final MaritalInfoModel? maritalInfo,
    final ExpectedPartnerModel? expectedLifePartner,
  }) = _$BiodataModelImpl;
  const _BiodataModel._() : super._();

  factory _BiodataModel.fromJson(Map<String, dynamic> json) =
      _$BiodataModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  @JsonKey(name: 'user')
  String get userId;
  @override
  @JsonKey(name: 'user_id')
  int? get userIdNumber;
  @override
  @JsonKey(name: 'bio_type')
  String get bioType;
  @override
  @JsonKey(name: 'date_of_birth')
  String get dateOfBirth;
  @override
  double get height;
  @override
  String get gender;
  @override
  double get weight;
  @override
  @JsonKey(name: 'blood_group')
  String get bloodGroup;
  @override
  @JsonKey(name: 'screen_color')
  String get screenColor;
  @override
  String get nationality;
  @override
  @JsonKey(name: 'marital_status')
  String get maritalStatus;
  @override
  String? get upzilla;
  @override
  String? get zilla;
  @override
  @JsonKey(name: 'views_count')
  int? get viewsCount;
  @override
  @JsonKey(name: 'likes_count')
  int? get likesCount;
  @override
  @JsonKey(name: 'dislikes_count')
  int? get dislikesCount;
  @override
  @JsonKey(name: 'purchases_count')
  int? get purchasesCount;
  @override
  @JsonKey(name: 'isFeatured')
  bool? get isFeatured;
  @override
  @JsonKey(name: 'isMarriageDone')
  bool? get isMarriageDone;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  String? get updatedAt;
  @override
  AddressModel? get address;
  @override
  @JsonKey(name: 'educationQualification')
  EducationModel? get educationQualification;
  @override
  PersonalInfoModel? get personalInfo;
  @override
  FamilyStatusModel? get familyStatus;
  @override
  OccupationModel? get occupation;
  @override
  MaritalInfoModel? get maritalInfo;
  @override
  ExpectedPartnerModel? get expectedLifePartner;

  /// Create a copy of BiodataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BiodataModelImplCopyWith<_$BiodataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
