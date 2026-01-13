// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expected_partner_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ExpectedPartnerModel _$ExpectedPartnerModelFromJson(Map<String, dynamic> json) {
  return _ExpectedPartnerModel.fromJson(json);
}

/// @nodoc
mixin _$ExpectedPartnerModel {
  AgeRangeModel? get age => throw _privateConstructorUsedError;
  List<String>? get color => throw _privateConstructorUsedError;
  HeightRangeModel? get height => throw _privateConstructorUsedError;
  @JsonKey(name: 'educational_qualifications')
  List<String>? get educationalQualifications =>
      throw _privateConstructorUsedError;
  List<String>? get zilla => throw _privateConstructorUsedError;
  @JsonKey(name: 'marital_status')
  List<String>? get maritalStatus => throw _privateConstructorUsedError;
  List<String>? get occupation => throw _privateConstructorUsedError;
  @JsonKey(name: 'economical_condition')
  List<String>? get economicalCondition => throw _privateConstructorUsedError;
  @JsonKey(name: 'expected_characteristics')
  String? get expectedCharacteristics => throw _privateConstructorUsedError;

  /// Serializes this ExpectedPartnerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExpectedPartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExpectedPartnerModelCopyWith<ExpectedPartnerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpectedPartnerModelCopyWith<$Res> {
  factory $ExpectedPartnerModelCopyWith(
    ExpectedPartnerModel value,
    $Res Function(ExpectedPartnerModel) then,
  ) = _$ExpectedPartnerModelCopyWithImpl<$Res, ExpectedPartnerModel>;
  @useResult
  $Res call({
    AgeRangeModel? age,
    List<String>? color,
    HeightRangeModel? height,
    @JsonKey(name: 'educational_qualifications')
    List<String>? educationalQualifications,
    List<String>? zilla,
    @JsonKey(name: 'marital_status') List<String>? maritalStatus,
    List<String>? occupation,
    @JsonKey(name: 'economical_condition') List<String>? economicalCondition,
    @JsonKey(name: 'expected_characteristics') String? expectedCharacteristics,
  });

  $AgeRangeModelCopyWith<$Res>? get age;
  $HeightRangeModelCopyWith<$Res>? get height;
}

/// @nodoc
class _$ExpectedPartnerModelCopyWithImpl<
  $Res,
  $Val extends ExpectedPartnerModel
>
    implements $ExpectedPartnerModelCopyWith<$Res> {
  _$ExpectedPartnerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExpectedPartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? age = freezed,
    Object? color = freezed,
    Object? height = freezed,
    Object? educationalQualifications = freezed,
    Object? zilla = freezed,
    Object? maritalStatus = freezed,
    Object? occupation = freezed,
    Object? economicalCondition = freezed,
    Object? expectedCharacteristics = freezed,
  }) {
    return _then(
      _value.copyWith(
            age: freezed == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                      as AgeRangeModel?,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            height: freezed == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as HeightRangeModel?,
            educationalQualifications: freezed == educationalQualifications
                ? _value.educationalQualifications
                : educationalQualifications // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            zilla: freezed == zilla
                ? _value.zilla
                : zilla // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            maritalStatus: freezed == maritalStatus
                ? _value.maritalStatus
                : maritalStatus // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            occupation: freezed == occupation
                ? _value.occupation
                : occupation // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            economicalCondition: freezed == economicalCondition
                ? _value.economicalCondition
                : economicalCondition // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            expectedCharacteristics: freezed == expectedCharacteristics
                ? _value.expectedCharacteristics
                : expectedCharacteristics // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ExpectedPartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AgeRangeModelCopyWith<$Res>? get age {
    if (_value.age == null) {
      return null;
    }

    return $AgeRangeModelCopyWith<$Res>(_value.age!, (value) {
      return _then(_value.copyWith(age: value) as $Val);
    });
  }

  /// Create a copy of ExpectedPartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HeightRangeModelCopyWith<$Res>? get height {
    if (_value.height == null) {
      return null;
    }

    return $HeightRangeModelCopyWith<$Res>(_value.height!, (value) {
      return _then(_value.copyWith(height: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExpectedPartnerModelImplCopyWith<$Res>
    implements $ExpectedPartnerModelCopyWith<$Res> {
  factory _$$ExpectedPartnerModelImplCopyWith(
    _$ExpectedPartnerModelImpl value,
    $Res Function(_$ExpectedPartnerModelImpl) then,
  ) = __$$ExpectedPartnerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AgeRangeModel? age,
    List<String>? color,
    HeightRangeModel? height,
    @JsonKey(name: 'educational_qualifications')
    List<String>? educationalQualifications,
    List<String>? zilla,
    @JsonKey(name: 'marital_status') List<String>? maritalStatus,
    List<String>? occupation,
    @JsonKey(name: 'economical_condition') List<String>? economicalCondition,
    @JsonKey(name: 'expected_characteristics') String? expectedCharacteristics,
  });

  @override
  $AgeRangeModelCopyWith<$Res>? get age;
  @override
  $HeightRangeModelCopyWith<$Res>? get height;
}

/// @nodoc
class __$$ExpectedPartnerModelImplCopyWithImpl<$Res>
    extends _$ExpectedPartnerModelCopyWithImpl<$Res, _$ExpectedPartnerModelImpl>
    implements _$$ExpectedPartnerModelImplCopyWith<$Res> {
  __$$ExpectedPartnerModelImplCopyWithImpl(
    _$ExpectedPartnerModelImpl _value,
    $Res Function(_$ExpectedPartnerModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExpectedPartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? age = freezed,
    Object? color = freezed,
    Object? height = freezed,
    Object? educationalQualifications = freezed,
    Object? zilla = freezed,
    Object? maritalStatus = freezed,
    Object? occupation = freezed,
    Object? economicalCondition = freezed,
    Object? expectedCharacteristics = freezed,
  }) {
    return _then(
      _$ExpectedPartnerModelImpl(
        age: freezed == age
            ? _value.age
            : age // ignore: cast_nullable_to_non_nullable
                  as AgeRangeModel?,
        color: freezed == color
            ? _value._color
            : color // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        height: freezed == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as HeightRangeModel?,
        educationalQualifications: freezed == educationalQualifications
            ? _value._educationalQualifications
            : educationalQualifications // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        zilla: freezed == zilla
            ? _value._zilla
            : zilla // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        maritalStatus: freezed == maritalStatus
            ? _value._maritalStatus
            : maritalStatus // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        occupation: freezed == occupation
            ? _value._occupation
            : occupation // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        economicalCondition: freezed == economicalCondition
            ? _value._economicalCondition
            : economicalCondition // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        expectedCharacteristics: freezed == expectedCharacteristics
            ? _value.expectedCharacteristics
            : expectedCharacteristics // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpectedPartnerModelImpl extends _ExpectedPartnerModel {
  const _$ExpectedPartnerModelImpl({
    this.age,
    final List<String>? color,
    this.height,
    @JsonKey(name: 'educational_qualifications')
    final List<String>? educationalQualifications,
    final List<String>? zilla,
    @JsonKey(name: 'marital_status') final List<String>? maritalStatus,
    final List<String>? occupation,
    @JsonKey(name: 'economical_condition')
    final List<String>? economicalCondition,
    @JsonKey(name: 'expected_characteristics') this.expectedCharacteristics,
  }) : _color = color,
       _educationalQualifications = educationalQualifications,
       _zilla = zilla,
       _maritalStatus = maritalStatus,
       _occupation = occupation,
       _economicalCondition = economicalCondition,
       super._();

  factory _$ExpectedPartnerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpectedPartnerModelImplFromJson(json);

  @override
  final AgeRangeModel? age;
  final List<String>? _color;
  @override
  List<String>? get color {
    final value = _color;
    if (value == null) return null;
    if (_color is EqualUnmodifiableListView) return _color;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final HeightRangeModel? height;
  final List<String>? _educationalQualifications;
  @override
  @JsonKey(name: 'educational_qualifications')
  List<String>? get educationalQualifications {
    final value = _educationalQualifications;
    if (value == null) return null;
    if (_educationalQualifications is EqualUnmodifiableListView)
      return _educationalQualifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _zilla;
  @override
  List<String>? get zilla {
    final value = _zilla;
    if (value == null) return null;
    if (_zilla is EqualUnmodifiableListView) return _zilla;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _maritalStatus;
  @override
  @JsonKey(name: 'marital_status')
  List<String>? get maritalStatus {
    final value = _maritalStatus;
    if (value == null) return null;
    if (_maritalStatus is EqualUnmodifiableListView) return _maritalStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _occupation;
  @override
  List<String>? get occupation {
    final value = _occupation;
    if (value == null) return null;
    if (_occupation is EqualUnmodifiableListView) return _occupation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _economicalCondition;
  @override
  @JsonKey(name: 'economical_condition')
  List<String>? get economicalCondition {
    final value = _economicalCondition;
    if (value == null) return null;
    if (_economicalCondition is EqualUnmodifiableListView)
      return _economicalCondition;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'expected_characteristics')
  final String? expectedCharacteristics;

  @override
  String toString() {
    return 'ExpectedPartnerModel(age: $age, color: $color, height: $height, educationalQualifications: $educationalQualifications, zilla: $zilla, maritalStatus: $maritalStatus, occupation: $occupation, economicalCondition: $economicalCondition, expectedCharacteristics: $expectedCharacteristics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpectedPartnerModelImpl &&
            (identical(other.age, age) || other.age == age) &&
            const DeepCollectionEquality().equals(other._color, _color) &&
            (identical(other.height, height) || other.height == height) &&
            const DeepCollectionEquality().equals(
              other._educationalQualifications,
              _educationalQualifications,
            ) &&
            const DeepCollectionEquality().equals(other._zilla, _zilla) &&
            const DeepCollectionEquality().equals(
              other._maritalStatus,
              _maritalStatus,
            ) &&
            const DeepCollectionEquality().equals(
              other._occupation,
              _occupation,
            ) &&
            const DeepCollectionEquality().equals(
              other._economicalCondition,
              _economicalCondition,
            ) &&
            (identical(
                  other.expectedCharacteristics,
                  expectedCharacteristics,
                ) ||
                other.expectedCharacteristics == expectedCharacteristics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    age,
    const DeepCollectionEquality().hash(_color),
    height,
    const DeepCollectionEquality().hash(_educationalQualifications),
    const DeepCollectionEquality().hash(_zilla),
    const DeepCollectionEquality().hash(_maritalStatus),
    const DeepCollectionEquality().hash(_occupation),
    const DeepCollectionEquality().hash(_economicalCondition),
    expectedCharacteristics,
  );

  /// Create a copy of ExpectedPartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpectedPartnerModelImplCopyWith<_$ExpectedPartnerModelImpl>
  get copyWith =>
      __$$ExpectedPartnerModelImplCopyWithImpl<_$ExpectedPartnerModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpectedPartnerModelImplToJson(this);
  }
}

abstract class _ExpectedPartnerModel extends ExpectedPartnerModel {
  const factory _ExpectedPartnerModel({
    final AgeRangeModel? age,
    final List<String>? color,
    final HeightRangeModel? height,
    @JsonKey(name: 'educational_qualifications')
    final List<String>? educationalQualifications,
    final List<String>? zilla,
    @JsonKey(name: 'marital_status') final List<String>? maritalStatus,
    final List<String>? occupation,
    @JsonKey(name: 'economical_condition')
    final List<String>? economicalCondition,
    @JsonKey(name: 'expected_characteristics')
    final String? expectedCharacteristics,
  }) = _$ExpectedPartnerModelImpl;
  const _ExpectedPartnerModel._() : super._();

  factory _ExpectedPartnerModel.fromJson(Map<String, dynamic> json) =
      _$ExpectedPartnerModelImpl.fromJson;

  @override
  AgeRangeModel? get age;
  @override
  List<String>? get color;
  @override
  HeightRangeModel? get height;
  @override
  @JsonKey(name: 'educational_qualifications')
  List<String>? get educationalQualifications;
  @override
  List<String>? get zilla;
  @override
  @JsonKey(name: 'marital_status')
  List<String>? get maritalStatus;
  @override
  List<String>? get occupation;
  @override
  @JsonKey(name: 'economical_condition')
  List<String>? get economicalCondition;
  @override
  @JsonKey(name: 'expected_characteristics')
  String? get expectedCharacteristics;

  /// Create a copy of ExpectedPartnerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExpectedPartnerModelImplCopyWith<_$ExpectedPartnerModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AgeRangeModel _$AgeRangeModelFromJson(Map<String, dynamic> json) {
  return _AgeRangeModel.fromJson(json);
}

/// @nodoc
mixin _$AgeRangeModel {
  int? get min => throw _privateConstructorUsedError;
  int? get max => throw _privateConstructorUsedError;

  /// Serializes this AgeRangeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AgeRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgeRangeModelCopyWith<AgeRangeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgeRangeModelCopyWith<$Res> {
  factory $AgeRangeModelCopyWith(
    AgeRangeModel value,
    $Res Function(AgeRangeModel) then,
  ) = _$AgeRangeModelCopyWithImpl<$Res, AgeRangeModel>;
  @useResult
  $Res call({int? min, int? max});
}

/// @nodoc
class _$AgeRangeModelCopyWithImpl<$Res, $Val extends AgeRangeModel>
    implements $AgeRangeModelCopyWith<$Res> {
  _$AgeRangeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AgeRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? min = freezed, Object? max = freezed}) {
    return _then(
      _value.copyWith(
            min: freezed == min
                ? _value.min
                : min // ignore: cast_nullable_to_non_nullable
                      as int?,
            max: freezed == max
                ? _value.max
                : max // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AgeRangeModelImplCopyWith<$Res>
    implements $AgeRangeModelCopyWith<$Res> {
  factory _$$AgeRangeModelImplCopyWith(
    _$AgeRangeModelImpl value,
    $Res Function(_$AgeRangeModelImpl) then,
  ) = __$$AgeRangeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? min, int? max});
}

/// @nodoc
class __$$AgeRangeModelImplCopyWithImpl<$Res>
    extends _$AgeRangeModelCopyWithImpl<$Res, _$AgeRangeModelImpl>
    implements _$$AgeRangeModelImplCopyWith<$Res> {
  __$$AgeRangeModelImplCopyWithImpl(
    _$AgeRangeModelImpl _value,
    $Res Function(_$AgeRangeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AgeRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? min = freezed, Object? max = freezed}) {
    return _then(
      _$AgeRangeModelImpl(
        min: freezed == min
            ? _value.min
            : min // ignore: cast_nullable_to_non_nullable
                  as int?,
        max: freezed == max
            ? _value.max
            : max // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AgeRangeModelImpl extends _AgeRangeModel {
  const _$AgeRangeModelImpl({this.min, this.max}) : super._();

  factory _$AgeRangeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgeRangeModelImplFromJson(json);

  @override
  final int? min;
  @override
  final int? max;

  @override
  String toString() {
    return 'AgeRangeModel(min: $min, max: $max)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgeRangeModelImpl &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, min, max);

  /// Create a copy of AgeRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AgeRangeModelImplCopyWith<_$AgeRangeModelImpl> get copyWith =>
      __$$AgeRangeModelImplCopyWithImpl<_$AgeRangeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgeRangeModelImplToJson(this);
  }
}

abstract class _AgeRangeModel extends AgeRangeModel {
  const factory _AgeRangeModel({final int? min, final int? max}) =
      _$AgeRangeModelImpl;
  const _AgeRangeModel._() : super._();

  factory _AgeRangeModel.fromJson(Map<String, dynamic> json) =
      _$AgeRangeModelImpl.fromJson;

  @override
  int? get min;
  @override
  int? get max;

  /// Create a copy of AgeRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgeRangeModelImplCopyWith<_$AgeRangeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HeightRangeModel _$HeightRangeModelFromJson(Map<String, dynamic> json) {
  return _HeightRangeModel.fromJson(json);
}

/// @nodoc
mixin _$HeightRangeModel {
  double? get min => throw _privateConstructorUsedError;
  double? get max => throw _privateConstructorUsedError;

  /// Serializes this HeightRangeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HeightRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HeightRangeModelCopyWith<HeightRangeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HeightRangeModelCopyWith<$Res> {
  factory $HeightRangeModelCopyWith(
    HeightRangeModel value,
    $Res Function(HeightRangeModel) then,
  ) = _$HeightRangeModelCopyWithImpl<$Res, HeightRangeModel>;
  @useResult
  $Res call({double? min, double? max});
}

/// @nodoc
class _$HeightRangeModelCopyWithImpl<$Res, $Val extends HeightRangeModel>
    implements $HeightRangeModelCopyWith<$Res> {
  _$HeightRangeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HeightRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? min = freezed, Object? max = freezed}) {
    return _then(
      _value.copyWith(
            min: freezed == min
                ? _value.min
                : min // ignore: cast_nullable_to_non_nullable
                      as double?,
            max: freezed == max
                ? _value.max
                : max // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HeightRangeModelImplCopyWith<$Res>
    implements $HeightRangeModelCopyWith<$Res> {
  factory _$$HeightRangeModelImplCopyWith(
    _$HeightRangeModelImpl value,
    $Res Function(_$HeightRangeModelImpl) then,
  ) = __$$HeightRangeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? min, double? max});
}

/// @nodoc
class __$$HeightRangeModelImplCopyWithImpl<$Res>
    extends _$HeightRangeModelCopyWithImpl<$Res, _$HeightRangeModelImpl>
    implements _$$HeightRangeModelImplCopyWith<$Res> {
  __$$HeightRangeModelImplCopyWithImpl(
    _$HeightRangeModelImpl _value,
    $Res Function(_$HeightRangeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HeightRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? min = freezed, Object? max = freezed}) {
    return _then(
      _$HeightRangeModelImpl(
        min: freezed == min
            ? _value.min
            : min // ignore: cast_nullable_to_non_nullable
                  as double?,
        max: freezed == max
            ? _value.max
            : max // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HeightRangeModelImpl extends _HeightRangeModel {
  const _$HeightRangeModelImpl({this.min, this.max}) : super._();

  factory _$HeightRangeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HeightRangeModelImplFromJson(json);

  @override
  final double? min;
  @override
  final double? max;

  @override
  String toString() {
    return 'HeightRangeModel(min: $min, max: $max)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HeightRangeModelImpl &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, min, max);

  /// Create a copy of HeightRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HeightRangeModelImplCopyWith<_$HeightRangeModelImpl> get copyWith =>
      __$$HeightRangeModelImplCopyWithImpl<_$HeightRangeModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HeightRangeModelImplToJson(this);
  }
}

abstract class _HeightRangeModel extends HeightRangeModel {
  const factory _HeightRangeModel({final double? min, final double? max}) =
      _$HeightRangeModelImpl;
  const _HeightRangeModel._() : super._();

  factory _HeightRangeModel.fromJson(Map<String, dynamic> json) =
      _$HeightRangeModelImpl.fromJson;

  @override
  double? get min;
  @override
  double? get max;

  /// Create a copy of HeightRangeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HeightRangeModelImplCopyWith<_$HeightRangeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
