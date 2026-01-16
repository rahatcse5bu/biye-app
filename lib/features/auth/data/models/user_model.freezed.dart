// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_role')
  String get userRole => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_status')
  String get userStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'token_id')
  String? get tokenId => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get fcmToken => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  @JsonKey(name: 'edited_timeline_index')
  int get editedTimelineIndex => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_edited_timeline_index')
  int get lastEditedTimelineIndex => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call({
    @JsonKey(name: '_id') String id,
    String email,
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'user_role') String userRole,
    @JsonKey(name: 'user_status') String userStatus,
    @JsonKey(name: 'token_id') String? tokenId,
    String? token,
    String? name,
    String? gender,
    String? fcmToken,
    int points,
    @JsonKey(name: 'edited_timeline_index') int editedTimelineIndex,
    @JsonKey(name: 'last_edited_timeline_index') int lastEditedTimelineIndex,
  });
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? userId = null,
    Object? userRole = null,
    Object? userStatus = null,
    Object? tokenId = freezed,
    Object? token = freezed,
    Object? name = freezed,
    Object? gender = freezed,
    Object? fcmToken = freezed,
    Object? points = null,
    Object? editedTimelineIndex = null,
    Object? lastEditedTimelineIndex = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            userRole: null == userRole
                ? _value.userRole
                : userRole // ignore: cast_nullable_to_non_nullable
                      as String,
            userStatus: null == userStatus
                ? _value.userStatus
                : userStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            tokenId: freezed == tokenId
                ? _value.tokenId
                : tokenId // ignore: cast_nullable_to_non_nullable
                      as String?,
            token: freezed == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            gender: freezed == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String?,
            fcmToken: freezed == fcmToken
                ? _value.fcmToken
                : fcmToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
            editedTimelineIndex: null == editedTimelineIndex
                ? _value.editedTimelineIndex
                : editedTimelineIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            lastEditedTimelineIndex: null == lastEditedTimelineIndex
                ? _value.lastEditedTimelineIndex
                : lastEditedTimelineIndex // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: '_id') String id,
    String email,
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'user_role') String userRole,
    @JsonKey(name: 'user_status') String userStatus,
    @JsonKey(name: 'token_id') String? tokenId,
    String? token,
    String? name,
    String? gender,
    String? fcmToken,
    int points,
    @JsonKey(name: 'edited_timeline_index') int editedTimelineIndex,
    @JsonKey(name: 'last_edited_timeline_index') int lastEditedTimelineIndex,
  });
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? userId = null,
    Object? userRole = null,
    Object? userStatus = null,
    Object? tokenId = freezed,
    Object? token = freezed,
    Object? name = freezed,
    Object? gender = freezed,
    Object? fcmToken = freezed,
    Object? points = null,
    Object? editedTimelineIndex = null,
    Object? lastEditedTimelineIndex = null,
  }) {
    return _then(
      _$UserModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        userRole: null == userRole
            ? _value.userRole
            : userRole // ignore: cast_nullable_to_non_nullable
                  as String,
        userStatus: null == userStatus
            ? _value.userStatus
            : userStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        tokenId: freezed == tokenId
            ? _value.tokenId
            : tokenId // ignore: cast_nullable_to_non_nullable
                  as String?,
        token: freezed == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        gender: freezed == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String?,
        fcmToken: freezed == fcmToken
            ? _value.fcmToken
            : fcmToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
        editedTimelineIndex: null == editedTimelineIndex
            ? _value.editedTimelineIndex
            : editedTimelineIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        lastEditedTimelineIndex: null == lastEditedTimelineIndex
            ? _value.lastEditedTimelineIndex
            : lastEditedTimelineIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl extends _UserModel {
  const _$UserModelImpl({
    @JsonKey(name: '_id') required this.id,
    required this.email,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'user_role') required this.userRole,
    @JsonKey(name: 'user_status') required this.userStatus,
    @JsonKey(name: 'token_id') this.tokenId,
    this.token,
    this.name,
    this.gender,
    this.fcmToken,
    this.points = 0,
    @JsonKey(name: 'edited_timeline_index') this.editedTimelineIndex = 0,
    @JsonKey(name: 'last_edited_timeline_index')
    this.lastEditedTimelineIndex = 0,
  }) : super._();

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String email;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'user_role')
  final String userRole;
  @override
  @JsonKey(name: 'user_status')
  final String userStatus;
  @override
  @JsonKey(name: 'token_id')
  final String? tokenId;
  @override
  final String? token;
  @override
  final String? name;
  @override
  final String? gender;
  @override
  final String? fcmToken;
  @override
  @JsonKey()
  final int points;
  @override
  @JsonKey(name: 'edited_timeline_index')
  final int editedTimelineIndex;
  @override
  @JsonKey(name: 'last_edited_timeline_index')
  final int lastEditedTimelineIndex;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, userId: $userId, userRole: $userRole, userStatus: $userStatus, tokenId: $tokenId, token: $token, name: $name, gender: $gender, fcmToken: $fcmToken, points: $points, editedTimelineIndex: $editedTimelineIndex, lastEditedTimelineIndex: $lastEditedTimelineIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userRole, userRole) ||
                other.userRole == userRole) &&
            (identical(other.userStatus, userStatus) ||
                other.userStatus == userStatus) &&
            (identical(other.tokenId, tokenId) || other.tokenId == tokenId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.editedTimelineIndex, editedTimelineIndex) ||
                other.editedTimelineIndex == editedTimelineIndex) &&
            (identical(
                  other.lastEditedTimelineIndex,
                  lastEditedTimelineIndex,
                ) ||
                other.lastEditedTimelineIndex == lastEditedTimelineIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    userId,
    userRole,
    userStatus,
    tokenId,
    token,
    name,
    gender,
    fcmToken,
    points,
    editedTimelineIndex,
    lastEditedTimelineIndex,
  );

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel extends UserModel {
  const factory _UserModel({
    @JsonKey(name: '_id') required final String id,
    required final String email,
    @JsonKey(name: 'user_id') required final int userId,
    @JsonKey(name: 'user_role') required final String userRole,
    @JsonKey(name: 'user_status') required final String userStatus,
    @JsonKey(name: 'token_id') final String? tokenId,
    final String? token,
    final String? name,
    final String? gender,
    final String? fcmToken,
    final int points,
    @JsonKey(name: 'edited_timeline_index') final int editedTimelineIndex,
    @JsonKey(name: 'last_edited_timeline_index')
    final int lastEditedTimelineIndex,
  }) = _$UserModelImpl;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get email;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'user_role')
  String get userRole;
  @override
  @JsonKey(name: 'user_status')
  String get userStatus;
  @override
  @JsonKey(name: 'token_id')
  String? get tokenId;
  @override
  String? get token;
  @override
  String? get name;
  @override
  String? get gender;
  @override
  String? get fcmToken;
  @override
  int get points;
  @override
  @JsonKey(name: 'edited_timeline_index')
  int get editedTimelineIndex;
  @override
  @JsonKey(name: 'last_edited_timeline_index')
  int get lastEditedTimelineIndex;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
