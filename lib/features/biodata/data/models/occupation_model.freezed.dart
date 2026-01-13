// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'occupation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OccupationModel _$OccupationModelFromJson(Map<String, dynamic> json) {
  return _OccupationModel.fromJson(json);
}

/// @nodoc
mixin _$OccupationModel {
  List<String>? get occupation => throw _privateConstructorUsedError;
  @JsonKey(name: 'occupation_details')
  String? get occupationDetails => throw _privateConstructorUsedError;
  @JsonKey(name: 'monthly_income')
  int? get monthlyIncome => throw _privateConstructorUsedError;

  /// Serializes this OccupationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OccupationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OccupationModelCopyWith<OccupationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OccupationModelCopyWith<$Res> {
  factory $OccupationModelCopyWith(
    OccupationModel value,
    $Res Function(OccupationModel) then,
  ) = _$OccupationModelCopyWithImpl<$Res, OccupationModel>;
  @useResult
  $Res call({
    List<String>? occupation,
    @JsonKey(name: 'occupation_details') String? occupationDetails,
    @JsonKey(name: 'monthly_income') int? monthlyIncome,
  });
}

/// @nodoc
class _$OccupationModelCopyWithImpl<$Res, $Val extends OccupationModel>
    implements $OccupationModelCopyWith<$Res> {
  _$OccupationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OccupationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? occupation = freezed,
    Object? occupationDetails = freezed,
    Object? monthlyIncome = freezed,
  }) {
    return _then(
      _value.copyWith(
            occupation: freezed == occupation
                ? _value.occupation
                : occupation // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            occupationDetails: freezed == occupationDetails
                ? _value.occupationDetails
                : occupationDetails // ignore: cast_nullable_to_non_nullable
                      as String?,
            monthlyIncome: freezed == monthlyIncome
                ? _value.monthlyIncome
                : monthlyIncome // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OccupationModelImplCopyWith<$Res>
    implements $OccupationModelCopyWith<$Res> {
  factory _$$OccupationModelImplCopyWith(
    _$OccupationModelImpl value,
    $Res Function(_$OccupationModelImpl) then,
  ) = __$$OccupationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<String>? occupation,
    @JsonKey(name: 'occupation_details') String? occupationDetails,
    @JsonKey(name: 'monthly_income') int? monthlyIncome,
  });
}

/// @nodoc
class __$$OccupationModelImplCopyWithImpl<$Res>
    extends _$OccupationModelCopyWithImpl<$Res, _$OccupationModelImpl>
    implements _$$OccupationModelImplCopyWith<$Res> {
  __$$OccupationModelImplCopyWithImpl(
    _$OccupationModelImpl _value,
    $Res Function(_$OccupationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OccupationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? occupation = freezed,
    Object? occupationDetails = freezed,
    Object? monthlyIncome = freezed,
  }) {
    return _then(
      _$OccupationModelImpl(
        occupation: freezed == occupation
            ? _value._occupation
            : occupation // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        occupationDetails: freezed == occupationDetails
            ? _value.occupationDetails
            : occupationDetails // ignore: cast_nullable_to_non_nullable
                  as String?,
        monthlyIncome: freezed == monthlyIncome
            ? _value.monthlyIncome
            : monthlyIncome // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OccupationModelImpl extends _OccupationModel {
  const _$OccupationModelImpl({
    final List<String>? occupation,
    @JsonKey(name: 'occupation_details') this.occupationDetails,
    @JsonKey(name: 'monthly_income') this.monthlyIncome,
  }) : _occupation = occupation,
       super._();

  factory _$OccupationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OccupationModelImplFromJson(json);

  final List<String>? _occupation;
  @override
  List<String>? get occupation {
    final value = _occupation;
    if (value == null) return null;
    if (_occupation is EqualUnmodifiableListView) return _occupation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'occupation_details')
  final String? occupationDetails;
  @override
  @JsonKey(name: 'monthly_income')
  final int? monthlyIncome;

  @override
  String toString() {
    return 'OccupationModel(occupation: $occupation, occupationDetails: $occupationDetails, monthlyIncome: $monthlyIncome)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OccupationModelImpl &&
            const DeepCollectionEquality().equals(
              other._occupation,
              _occupation,
            ) &&
            (identical(other.occupationDetails, occupationDetails) ||
                other.occupationDetails == occupationDetails) &&
            (identical(other.monthlyIncome, monthlyIncome) ||
                other.monthlyIncome == monthlyIncome));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_occupation),
    occupationDetails,
    monthlyIncome,
  );

  /// Create a copy of OccupationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OccupationModelImplCopyWith<_$OccupationModelImpl> get copyWith =>
      __$$OccupationModelImplCopyWithImpl<_$OccupationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OccupationModelImplToJson(this);
  }
}

abstract class _OccupationModel extends OccupationModel {
  const factory _OccupationModel({
    final List<String>? occupation,
    @JsonKey(name: 'occupation_details') final String? occupationDetails,
    @JsonKey(name: 'monthly_income') final int? monthlyIncome,
  }) = _$OccupationModelImpl;
  const _OccupationModel._() : super._();

  factory _OccupationModel.fromJson(Map<String, dynamic> json) =
      _$OccupationModelImpl.fromJson;

  @override
  List<String>? get occupation;
  @override
  @JsonKey(name: 'occupation_details')
  String? get occupationDetails;
  @override
  @JsonKey(name: 'monthly_income')
  int? get monthlyIncome;

  /// Create a copy of OccupationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OccupationModelImplCopyWith<_$OccupationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
