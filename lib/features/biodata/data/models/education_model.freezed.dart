// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'education_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EducationModel _$EducationModelFromJson(Map<String, dynamic> json) {
  return _EducationModel.fromJson(json);
}

/// @nodoc
mixin _$EducationModel {
  @JsonKey(name: 'education_medium')
  String? get educationMedium => throw _privateConstructorUsedError;
  @JsonKey(name: 'highest_edu_level')
  String? get highestEduLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'others_edu')
  String? get othersEdu => throw _privateConstructorUsedError;
  @JsonKey(name: 'deeni_edu')
  List<String>? get deeniEdu => throw _privateConstructorUsedError;
  @JsonKey(name: 'ssc_year')
  int? get sscYear => throw _privateConstructorUsedError;
  @JsonKey(name: 'ssc_group')
  String? get sscGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'ssc_result')
  String? get sscResult => throw _privateConstructorUsedError;
  @JsonKey(name: 'diploma_sub')
  String? get diplomaSub => throw _privateConstructorUsedError;
  @JsonKey(name: 'diploma_inst')
  String? get diplomaInst => throw _privateConstructorUsedError;
  @JsonKey(name: 'diploma_pass_year')
  int? get diplomaPassYear => throw _privateConstructorUsedError;

  /// Serializes this EducationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EducationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EducationModelCopyWith<EducationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EducationModelCopyWith<$Res> {
  factory $EducationModelCopyWith(
    EducationModel value,
    $Res Function(EducationModel) then,
  ) = _$EducationModelCopyWithImpl<$Res, EducationModel>;
  @useResult
  $Res call({
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
  });
}

/// @nodoc
class _$EducationModelCopyWithImpl<$Res, $Val extends EducationModel>
    implements $EducationModelCopyWith<$Res> {
  _$EducationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EducationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? educationMedium = freezed,
    Object? highestEduLevel = freezed,
    Object? othersEdu = freezed,
    Object? deeniEdu = freezed,
    Object? sscYear = freezed,
    Object? sscGroup = freezed,
    Object? sscResult = freezed,
    Object? diplomaSub = freezed,
    Object? diplomaInst = freezed,
    Object? diplomaPassYear = freezed,
  }) {
    return _then(
      _value.copyWith(
            educationMedium: freezed == educationMedium
                ? _value.educationMedium
                : educationMedium // ignore: cast_nullable_to_non_nullable
                      as String?,
            highestEduLevel: freezed == highestEduLevel
                ? _value.highestEduLevel
                : highestEduLevel // ignore: cast_nullable_to_non_nullable
                      as String?,
            othersEdu: freezed == othersEdu
                ? _value.othersEdu
                : othersEdu // ignore: cast_nullable_to_non_nullable
                      as String?,
            deeniEdu: freezed == deeniEdu
                ? _value.deeniEdu
                : deeniEdu // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            sscYear: freezed == sscYear
                ? _value.sscYear
                : sscYear // ignore: cast_nullable_to_non_nullable
                      as int?,
            sscGroup: freezed == sscGroup
                ? _value.sscGroup
                : sscGroup // ignore: cast_nullable_to_non_nullable
                      as String?,
            sscResult: freezed == sscResult
                ? _value.sscResult
                : sscResult // ignore: cast_nullable_to_non_nullable
                      as String?,
            diplomaSub: freezed == diplomaSub
                ? _value.diplomaSub
                : diplomaSub // ignore: cast_nullable_to_non_nullable
                      as String?,
            diplomaInst: freezed == diplomaInst
                ? _value.diplomaInst
                : diplomaInst // ignore: cast_nullable_to_non_nullable
                      as String?,
            diplomaPassYear: freezed == diplomaPassYear
                ? _value.diplomaPassYear
                : diplomaPassYear // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EducationModelImplCopyWith<$Res>
    implements $EducationModelCopyWith<$Res> {
  factory _$$EducationModelImplCopyWith(
    _$EducationModelImpl value,
    $Res Function(_$EducationModelImpl) then,
  ) = __$$EducationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
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
  });
}

/// @nodoc
class __$$EducationModelImplCopyWithImpl<$Res>
    extends _$EducationModelCopyWithImpl<$Res, _$EducationModelImpl>
    implements _$$EducationModelImplCopyWith<$Res> {
  __$$EducationModelImplCopyWithImpl(
    _$EducationModelImpl _value,
    $Res Function(_$EducationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EducationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? educationMedium = freezed,
    Object? highestEduLevel = freezed,
    Object? othersEdu = freezed,
    Object? deeniEdu = freezed,
    Object? sscYear = freezed,
    Object? sscGroup = freezed,
    Object? sscResult = freezed,
    Object? diplomaSub = freezed,
    Object? diplomaInst = freezed,
    Object? diplomaPassYear = freezed,
  }) {
    return _then(
      _$EducationModelImpl(
        educationMedium: freezed == educationMedium
            ? _value.educationMedium
            : educationMedium // ignore: cast_nullable_to_non_nullable
                  as String?,
        highestEduLevel: freezed == highestEduLevel
            ? _value.highestEduLevel
            : highestEduLevel // ignore: cast_nullable_to_non_nullable
                  as String?,
        othersEdu: freezed == othersEdu
            ? _value.othersEdu
            : othersEdu // ignore: cast_nullable_to_non_nullable
                  as String?,
        deeniEdu: freezed == deeniEdu
            ? _value._deeniEdu
            : deeniEdu // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        sscYear: freezed == sscYear
            ? _value.sscYear
            : sscYear // ignore: cast_nullable_to_non_nullable
                  as int?,
        sscGroup: freezed == sscGroup
            ? _value.sscGroup
            : sscGroup // ignore: cast_nullable_to_non_nullable
                  as String?,
        sscResult: freezed == sscResult
            ? _value.sscResult
            : sscResult // ignore: cast_nullable_to_non_nullable
                  as String?,
        diplomaSub: freezed == diplomaSub
            ? _value.diplomaSub
            : diplomaSub // ignore: cast_nullable_to_non_nullable
                  as String?,
        diplomaInst: freezed == diplomaInst
            ? _value.diplomaInst
            : diplomaInst // ignore: cast_nullable_to_non_nullable
                  as String?,
        diplomaPassYear: freezed == diplomaPassYear
            ? _value.diplomaPassYear
            : diplomaPassYear // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EducationModelImpl extends _EducationModel {
  const _$EducationModelImpl({
    @JsonKey(name: 'education_medium') this.educationMedium,
    @JsonKey(name: 'highest_edu_level') this.highestEduLevel,
    @JsonKey(name: 'others_edu') this.othersEdu,
    @JsonKey(name: 'deeni_edu') final List<String>? deeniEdu,
    @JsonKey(name: 'ssc_year') this.sscYear,
    @JsonKey(name: 'ssc_group') this.sscGroup,
    @JsonKey(name: 'ssc_result') this.sscResult,
    @JsonKey(name: 'diploma_sub') this.diplomaSub,
    @JsonKey(name: 'diploma_inst') this.diplomaInst,
    @JsonKey(name: 'diploma_pass_year') this.diplomaPassYear,
  }) : _deeniEdu = deeniEdu,
       super._();

  factory _$EducationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EducationModelImplFromJson(json);

  @override
  @JsonKey(name: 'education_medium')
  final String? educationMedium;
  @override
  @JsonKey(name: 'highest_edu_level')
  final String? highestEduLevel;
  @override
  @JsonKey(name: 'others_edu')
  final String? othersEdu;
  final List<String>? _deeniEdu;
  @override
  @JsonKey(name: 'deeni_edu')
  List<String>? get deeniEdu {
    final value = _deeniEdu;
    if (value == null) return null;
    if (_deeniEdu is EqualUnmodifiableListView) return _deeniEdu;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'ssc_year')
  final int? sscYear;
  @override
  @JsonKey(name: 'ssc_group')
  final String? sscGroup;
  @override
  @JsonKey(name: 'ssc_result')
  final String? sscResult;
  @override
  @JsonKey(name: 'diploma_sub')
  final String? diplomaSub;
  @override
  @JsonKey(name: 'diploma_inst')
  final String? diplomaInst;
  @override
  @JsonKey(name: 'diploma_pass_year')
  final int? diplomaPassYear;

  @override
  String toString() {
    return 'EducationModel(educationMedium: $educationMedium, highestEduLevel: $highestEduLevel, othersEdu: $othersEdu, deeniEdu: $deeniEdu, sscYear: $sscYear, sscGroup: $sscGroup, sscResult: $sscResult, diplomaSub: $diplomaSub, diplomaInst: $diplomaInst, diplomaPassYear: $diplomaPassYear)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EducationModelImpl &&
            (identical(other.educationMedium, educationMedium) ||
                other.educationMedium == educationMedium) &&
            (identical(other.highestEduLevel, highestEduLevel) ||
                other.highestEduLevel == highestEduLevel) &&
            (identical(other.othersEdu, othersEdu) ||
                other.othersEdu == othersEdu) &&
            const DeepCollectionEquality().equals(other._deeniEdu, _deeniEdu) &&
            (identical(other.sscYear, sscYear) || other.sscYear == sscYear) &&
            (identical(other.sscGroup, sscGroup) ||
                other.sscGroup == sscGroup) &&
            (identical(other.sscResult, sscResult) ||
                other.sscResult == sscResult) &&
            (identical(other.diplomaSub, diplomaSub) ||
                other.diplomaSub == diplomaSub) &&
            (identical(other.diplomaInst, diplomaInst) ||
                other.diplomaInst == diplomaInst) &&
            (identical(other.diplomaPassYear, diplomaPassYear) ||
                other.diplomaPassYear == diplomaPassYear));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    educationMedium,
    highestEduLevel,
    othersEdu,
    const DeepCollectionEquality().hash(_deeniEdu),
    sscYear,
    sscGroup,
    sscResult,
    diplomaSub,
    diplomaInst,
    diplomaPassYear,
  );

  /// Create a copy of EducationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EducationModelImplCopyWith<_$EducationModelImpl> get copyWith =>
      __$$EducationModelImplCopyWithImpl<_$EducationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EducationModelImplToJson(this);
  }
}

abstract class _EducationModel extends EducationModel {
  const factory _EducationModel({
    @JsonKey(name: 'education_medium') final String? educationMedium,
    @JsonKey(name: 'highest_edu_level') final String? highestEduLevel,
    @JsonKey(name: 'others_edu') final String? othersEdu,
    @JsonKey(name: 'deeni_edu') final List<String>? deeniEdu,
    @JsonKey(name: 'ssc_year') final int? sscYear,
    @JsonKey(name: 'ssc_group') final String? sscGroup,
    @JsonKey(name: 'ssc_result') final String? sscResult,
    @JsonKey(name: 'diploma_sub') final String? diplomaSub,
    @JsonKey(name: 'diploma_inst') final String? diplomaInst,
    @JsonKey(name: 'diploma_pass_year') final int? diplomaPassYear,
  }) = _$EducationModelImpl;
  const _EducationModel._() : super._();

  factory _EducationModel.fromJson(Map<String, dynamic> json) =
      _$EducationModelImpl.fromJson;

  @override
  @JsonKey(name: 'education_medium')
  String? get educationMedium;
  @override
  @JsonKey(name: 'highest_edu_level')
  String? get highestEduLevel;
  @override
  @JsonKey(name: 'others_edu')
  String? get othersEdu;
  @override
  @JsonKey(name: 'deeni_edu')
  List<String>? get deeniEdu;
  @override
  @JsonKey(name: 'ssc_year')
  int? get sscYear;
  @override
  @JsonKey(name: 'ssc_group')
  String? get sscGroup;
  @override
  @JsonKey(name: 'ssc_result')
  String? get sscResult;
  @override
  @JsonKey(name: 'diploma_sub')
  String? get diplomaSub;
  @override
  @JsonKey(name: 'diploma_inst')
  String? get diplomaInst;
  @override
  @JsonKey(name: 'diploma_pass_year')
  int? get diplomaPassYear;

  /// Create a copy of EducationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EducationModelImplCopyWith<_$EducationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
