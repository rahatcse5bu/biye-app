// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return _AddressModel.fromJson(json);
}

/// @nodoc
mixin _$AddressModel {
  @JsonKey(name: 'permanent_address')
  String? get permanentAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'present_address')
  String? get presentAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'grown_up')
  String? get grownUp => throw _privateConstructorUsedError;
  @JsonKey(name: 'present_area')
  String? get presentArea => throw _privateConstructorUsedError;
  @JsonKey(name: 'permanent_area')
  String? get permanentArea => throw _privateConstructorUsedError;
  String? get zilla => throw _privateConstructorUsedError;
  String? get upzilla => throw _privateConstructorUsedError;
  String? get division => throw _privateConstructorUsedError;
  @JsonKey(name: 'present_zilla')
  String? get presentZilla => throw _privateConstructorUsedError;
  @JsonKey(name: 'present_upzilla')
  String? get presentUpzilla => throw _privateConstructorUsedError;
  @JsonKey(name: 'present_division')
  String? get presentDivision => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  int? get zip => throw _privateConstructorUsedError;

  /// Serializes this AddressModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddressModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressModelCopyWith<AddressModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressModelCopyWith<$Res> {
  factory $AddressModelCopyWith(
    AddressModel value,
    $Res Function(AddressModel) then,
  ) = _$AddressModelCopyWithImpl<$Res, AddressModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'permanent_address') String? permanentAddress,
    @JsonKey(name: 'present_address') String? presentAddress,
    @JsonKey(name: 'grown_up') String? grownUp,
    @JsonKey(name: 'present_area') String? presentArea,
    @JsonKey(name: 'permanent_area') String? permanentArea,
    String? zilla,
    String? upzilla,
    String? division,
    @JsonKey(name: 'present_zilla') String? presentZilla,
    @JsonKey(name: 'present_upzilla') String? presentUpzilla,
    @JsonKey(name: 'present_division') String? presentDivision,
    String? city,
    int? zip,
  });
}

/// @nodoc
class _$AddressModelCopyWithImpl<$Res, $Val extends AddressModel>
    implements $AddressModelCopyWith<$Res> {
  _$AddressModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? permanentAddress = freezed,
    Object? presentAddress = freezed,
    Object? grownUp = freezed,
    Object? presentArea = freezed,
    Object? permanentArea = freezed,
    Object? zilla = freezed,
    Object? upzilla = freezed,
    Object? division = freezed,
    Object? presentZilla = freezed,
    Object? presentUpzilla = freezed,
    Object? presentDivision = freezed,
    Object? city = freezed,
    Object? zip = freezed,
  }) {
    return _then(
      _value.copyWith(
            permanentAddress: freezed == permanentAddress
                ? _value.permanentAddress
                : permanentAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            presentAddress: freezed == presentAddress
                ? _value.presentAddress
                : presentAddress // ignore: cast_nullable_to_non_nullable
                      as String?,
            grownUp: freezed == grownUp
                ? _value.grownUp
                : grownUp // ignore: cast_nullable_to_non_nullable
                      as String?,
            presentArea: freezed == presentArea
                ? _value.presentArea
                : presentArea // ignore: cast_nullable_to_non_nullable
                      as String?,
            permanentArea: freezed == permanentArea
                ? _value.permanentArea
                : permanentArea // ignore: cast_nullable_to_non_nullable
                      as String?,
            zilla: freezed == zilla
                ? _value.zilla
                : zilla // ignore: cast_nullable_to_non_nullable
                      as String?,
            upzilla: freezed == upzilla
                ? _value.upzilla
                : upzilla // ignore: cast_nullable_to_non_nullable
                      as String?,
            division: freezed == division
                ? _value.division
                : division // ignore: cast_nullable_to_non_nullable
                      as String?,
            presentZilla: freezed == presentZilla
                ? _value.presentZilla
                : presentZilla // ignore: cast_nullable_to_non_nullable
                      as String?,
            presentUpzilla: freezed == presentUpzilla
                ? _value.presentUpzilla
                : presentUpzilla // ignore: cast_nullable_to_non_nullable
                      as String?,
            presentDivision: freezed == presentDivision
                ? _value.presentDivision
                : presentDivision // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            zip: freezed == zip
                ? _value.zip
                : zip // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddressModelImplCopyWith<$Res>
    implements $AddressModelCopyWith<$Res> {
  factory _$$AddressModelImplCopyWith(
    _$AddressModelImpl value,
    $Res Function(_$AddressModelImpl) then,
  ) = __$$AddressModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'permanent_address') String? permanentAddress,
    @JsonKey(name: 'present_address') String? presentAddress,
    @JsonKey(name: 'grown_up') String? grownUp,
    @JsonKey(name: 'present_area') String? presentArea,
    @JsonKey(name: 'permanent_area') String? permanentArea,
    String? zilla,
    String? upzilla,
    String? division,
    @JsonKey(name: 'present_zilla') String? presentZilla,
    @JsonKey(name: 'present_upzilla') String? presentUpzilla,
    @JsonKey(name: 'present_division') String? presentDivision,
    String? city,
    int? zip,
  });
}

/// @nodoc
class __$$AddressModelImplCopyWithImpl<$Res>
    extends _$AddressModelCopyWithImpl<$Res, _$AddressModelImpl>
    implements _$$AddressModelImplCopyWith<$Res> {
  __$$AddressModelImplCopyWithImpl(
    _$AddressModelImpl _value,
    $Res Function(_$AddressModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddressModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? permanentAddress = freezed,
    Object? presentAddress = freezed,
    Object? grownUp = freezed,
    Object? presentArea = freezed,
    Object? permanentArea = freezed,
    Object? zilla = freezed,
    Object? upzilla = freezed,
    Object? division = freezed,
    Object? presentZilla = freezed,
    Object? presentUpzilla = freezed,
    Object? presentDivision = freezed,
    Object? city = freezed,
    Object? zip = freezed,
  }) {
    return _then(
      _$AddressModelImpl(
        permanentAddress: freezed == permanentAddress
            ? _value.permanentAddress
            : permanentAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        presentAddress: freezed == presentAddress
            ? _value.presentAddress
            : presentAddress // ignore: cast_nullable_to_non_nullable
                  as String?,
        grownUp: freezed == grownUp
            ? _value.grownUp
            : grownUp // ignore: cast_nullable_to_non_nullable
                  as String?,
        presentArea: freezed == presentArea
            ? _value.presentArea
            : presentArea // ignore: cast_nullable_to_non_nullable
                  as String?,
        permanentArea: freezed == permanentArea
            ? _value.permanentArea
            : permanentArea // ignore: cast_nullable_to_non_nullable
                  as String?,
        zilla: freezed == zilla
            ? _value.zilla
            : zilla // ignore: cast_nullable_to_non_nullable
                  as String?,
        upzilla: freezed == upzilla
            ? _value.upzilla
            : upzilla // ignore: cast_nullable_to_non_nullable
                  as String?,
        division: freezed == division
            ? _value.division
            : division // ignore: cast_nullable_to_non_nullable
                  as String?,
        presentZilla: freezed == presentZilla
            ? _value.presentZilla
            : presentZilla // ignore: cast_nullable_to_non_nullable
                  as String?,
        presentUpzilla: freezed == presentUpzilla
            ? _value.presentUpzilla
            : presentUpzilla // ignore: cast_nullable_to_non_nullable
                  as String?,
        presentDivision: freezed == presentDivision
            ? _value.presentDivision
            : presentDivision // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        zip: freezed == zip
            ? _value.zip
            : zip // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressModelImpl extends _AddressModel {
  const _$AddressModelImpl({
    @JsonKey(name: 'permanent_address') this.permanentAddress,
    @JsonKey(name: 'present_address') this.presentAddress,
    @JsonKey(name: 'grown_up') this.grownUp,
    @JsonKey(name: 'present_area') this.presentArea,
    @JsonKey(name: 'permanent_area') this.permanentArea,
    this.zilla,
    this.upzilla,
    this.division,
    @JsonKey(name: 'present_zilla') this.presentZilla,
    @JsonKey(name: 'present_upzilla') this.presentUpzilla,
    @JsonKey(name: 'present_division') this.presentDivision,
    this.city,
    this.zip,
  }) : super._();

  factory _$AddressModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressModelImplFromJson(json);

  @override
  @JsonKey(name: 'permanent_address')
  final String? permanentAddress;
  @override
  @JsonKey(name: 'present_address')
  final String? presentAddress;
  @override
  @JsonKey(name: 'grown_up')
  final String? grownUp;
  @override
  @JsonKey(name: 'present_area')
  final String? presentArea;
  @override
  @JsonKey(name: 'permanent_area')
  final String? permanentArea;
  @override
  final String? zilla;
  @override
  final String? upzilla;
  @override
  final String? division;
  @override
  @JsonKey(name: 'present_zilla')
  final String? presentZilla;
  @override
  @JsonKey(name: 'present_upzilla')
  final String? presentUpzilla;
  @override
  @JsonKey(name: 'present_division')
  final String? presentDivision;
  @override
  final String? city;
  @override
  final int? zip;

  @override
  String toString() {
    return 'AddressModel(permanentAddress: $permanentAddress, presentAddress: $presentAddress, grownUp: $grownUp, presentArea: $presentArea, permanentArea: $permanentArea, zilla: $zilla, upzilla: $upzilla, division: $division, presentZilla: $presentZilla, presentUpzilla: $presentUpzilla, presentDivision: $presentDivision, city: $city, zip: $zip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressModelImpl &&
            (identical(other.permanentAddress, permanentAddress) ||
                other.permanentAddress == permanentAddress) &&
            (identical(other.presentAddress, presentAddress) ||
                other.presentAddress == presentAddress) &&
            (identical(other.grownUp, grownUp) || other.grownUp == grownUp) &&
            (identical(other.presentArea, presentArea) ||
                other.presentArea == presentArea) &&
            (identical(other.permanentArea, permanentArea) ||
                other.permanentArea == permanentArea) &&
            (identical(other.zilla, zilla) || other.zilla == zilla) &&
            (identical(other.upzilla, upzilla) || other.upzilla == upzilla) &&
            (identical(other.division, division) ||
                other.division == division) &&
            (identical(other.presentZilla, presentZilla) ||
                other.presentZilla == presentZilla) &&
            (identical(other.presentUpzilla, presentUpzilla) ||
                other.presentUpzilla == presentUpzilla) &&
            (identical(other.presentDivision, presentDivision) ||
                other.presentDivision == presentDivision) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.zip, zip) || other.zip == zip));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    permanentAddress,
    presentAddress,
    grownUp,
    presentArea,
    permanentArea,
    zilla,
    upzilla,
    division,
    presentZilla,
    presentUpzilla,
    presentDivision,
    city,
    zip,
  );

  /// Create a copy of AddressModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressModelImplCopyWith<_$AddressModelImpl> get copyWith =>
      __$$AddressModelImplCopyWithImpl<_$AddressModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressModelImplToJson(this);
  }
}

abstract class _AddressModel extends AddressModel {
  const factory _AddressModel({
    @JsonKey(name: 'permanent_address') final String? permanentAddress,
    @JsonKey(name: 'present_address') final String? presentAddress,
    @JsonKey(name: 'grown_up') final String? grownUp,
    @JsonKey(name: 'present_area') final String? presentArea,
    @JsonKey(name: 'permanent_area') final String? permanentArea,
    final String? zilla,
    final String? upzilla,
    final String? division,
    @JsonKey(name: 'present_zilla') final String? presentZilla,
    @JsonKey(name: 'present_upzilla') final String? presentUpzilla,
    @JsonKey(name: 'present_division') final String? presentDivision,
    final String? city,
    final int? zip,
  }) = _$AddressModelImpl;
  const _AddressModel._() : super._();

  factory _AddressModel.fromJson(Map<String, dynamic> json) =
      _$AddressModelImpl.fromJson;

  @override
  @JsonKey(name: 'permanent_address')
  String? get permanentAddress;
  @override
  @JsonKey(name: 'present_address')
  String? get presentAddress;
  @override
  @JsonKey(name: 'grown_up')
  String? get grownUp;
  @override
  @JsonKey(name: 'present_area')
  String? get presentArea;
  @override
  @JsonKey(name: 'permanent_area')
  String? get permanentArea;
  @override
  String? get zilla;
  @override
  String? get upzilla;
  @override
  String? get division;
  @override
  @JsonKey(name: 'present_zilla')
  String? get presentZilla;
  @override
  @JsonKey(name: 'present_upzilla')
  String? get presentUpzilla;
  @override
  @JsonKey(name: 'present_division')
  String? get presentDivision;
  @override
  String? get city;
  @override
  int? get zip;

  /// Create a copy of AddressModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressModelImplCopyWith<_$AddressModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
