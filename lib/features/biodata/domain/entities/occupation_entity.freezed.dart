// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'occupation_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OccupationEntity {
  List<String>? get occupation => throw _privateConstructorUsedError;
  String? get occupationDetails => throw _privateConstructorUsedError;
  int? get monthlyIncome => throw _privateConstructorUsedError;

  /// Create a copy of OccupationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OccupationEntityCopyWith<OccupationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OccupationEntityCopyWith<$Res> {
  factory $OccupationEntityCopyWith(
    OccupationEntity value,
    $Res Function(OccupationEntity) then,
  ) = _$OccupationEntityCopyWithImpl<$Res, OccupationEntity>;
  @useResult
  $Res call({
    List<String>? occupation,
    String? occupationDetails,
    int? monthlyIncome,
  });
}

/// @nodoc
class _$OccupationEntityCopyWithImpl<$Res, $Val extends OccupationEntity>
    implements $OccupationEntityCopyWith<$Res> {
  _$OccupationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OccupationEntity
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
abstract class _$$OccupationEntityImplCopyWith<$Res>
    implements $OccupationEntityCopyWith<$Res> {
  factory _$$OccupationEntityImplCopyWith(
    _$OccupationEntityImpl value,
    $Res Function(_$OccupationEntityImpl) then,
  ) = __$$OccupationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<String>? occupation,
    String? occupationDetails,
    int? monthlyIncome,
  });
}

/// @nodoc
class __$$OccupationEntityImplCopyWithImpl<$Res>
    extends _$OccupationEntityCopyWithImpl<$Res, _$OccupationEntityImpl>
    implements _$$OccupationEntityImplCopyWith<$Res> {
  __$$OccupationEntityImplCopyWithImpl(
    _$OccupationEntityImpl _value,
    $Res Function(_$OccupationEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OccupationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? occupation = freezed,
    Object? occupationDetails = freezed,
    Object? monthlyIncome = freezed,
  }) {
    return _then(
      _$OccupationEntityImpl(
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

class _$OccupationEntityImpl implements _OccupationEntity {
  const _$OccupationEntityImpl({
    final List<String>? occupation,
    this.occupationDetails,
    this.monthlyIncome,
  }) : _occupation = occupation;

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
  final String? occupationDetails;
  @override
  final int? monthlyIncome;

  @override
  String toString() {
    return 'OccupationEntity(occupation: $occupation, occupationDetails: $occupationDetails, monthlyIncome: $monthlyIncome)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OccupationEntityImpl &&
            const DeepCollectionEquality().equals(
              other._occupation,
              _occupation,
            ) &&
            (identical(other.occupationDetails, occupationDetails) ||
                other.occupationDetails == occupationDetails) &&
            (identical(other.monthlyIncome, monthlyIncome) ||
                other.monthlyIncome == monthlyIncome));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_occupation),
    occupationDetails,
    monthlyIncome,
  );

  /// Create a copy of OccupationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OccupationEntityImplCopyWith<_$OccupationEntityImpl> get copyWith =>
      __$$OccupationEntityImplCopyWithImpl<_$OccupationEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _OccupationEntity implements OccupationEntity {
  const factory _OccupationEntity({
    final List<String>? occupation,
    final String? occupationDetails,
    final int? monthlyIncome,
  }) = _$OccupationEntityImpl;

  @override
  List<String>? get occupation;
  @override
  String? get occupationDetails;
  @override
  int? get monthlyIncome;

  /// Create a copy of OccupationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OccupationEntityImplCopyWith<_$OccupationEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
