// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'in_progress_session_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$InProgressSessionInfo {
  String get sessionId => throw _privateConstructorUsedError;
  String get templateName => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  String? get templateId => throw _privateConstructorUsedError;

  /// Create a copy of InProgressSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InProgressSessionInfoCopyWith<InProgressSessionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InProgressSessionInfoCopyWith<$Res> {
  factory $InProgressSessionInfoCopyWith(
    InProgressSessionInfo value,
    $Res Function(InProgressSessionInfo) then,
  ) = _$InProgressSessionInfoCopyWithImpl<$Res, InProgressSessionInfo>;
  @useResult
  $Res call({
    String sessionId,
    String templateName,
    DateTime startedAt,
    String? templateId,
  });
}

/// @nodoc
class _$InProgressSessionInfoCopyWithImpl<
  $Res,
  $Val extends InProgressSessionInfo
>
    implements $InProgressSessionInfoCopyWith<$Res> {
  _$InProgressSessionInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InProgressSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? templateName = null,
    Object? startedAt = null,
    Object? templateId = freezed,
  }) {
    return _then(
      _value.copyWith(
            sessionId: null == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                      as String,
            templateName: null == templateName
                ? _value.templateName
                : templateName // ignore: cast_nullable_to_non_nullable
                      as String,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            templateId: freezed == templateId
                ? _value.templateId
                : templateId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InProgressSessionInfoImplCopyWith<$Res>
    implements $InProgressSessionInfoCopyWith<$Res> {
  factory _$$InProgressSessionInfoImplCopyWith(
    _$InProgressSessionInfoImpl value,
    $Res Function(_$InProgressSessionInfoImpl) then,
  ) = __$$InProgressSessionInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String sessionId,
    String templateName,
    DateTime startedAt,
    String? templateId,
  });
}

/// @nodoc
class __$$InProgressSessionInfoImplCopyWithImpl<$Res>
    extends
        _$InProgressSessionInfoCopyWithImpl<$Res, _$InProgressSessionInfoImpl>
    implements _$$InProgressSessionInfoImplCopyWith<$Res> {
  __$$InProgressSessionInfoImplCopyWithImpl(
    _$InProgressSessionInfoImpl _value,
    $Res Function(_$InProgressSessionInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InProgressSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? templateName = null,
    Object? startedAt = null,
    Object? templateId = freezed,
  }) {
    return _then(
      _$InProgressSessionInfoImpl(
        sessionId: null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as String,
        templateName: null == templateName
            ? _value.templateName
            : templateName // ignore: cast_nullable_to_non_nullable
                  as String,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        templateId: freezed == templateId
            ? _value.templateId
            : templateId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$InProgressSessionInfoImpl extends _InProgressSessionInfo {
  const _$InProgressSessionInfoImpl({
    required this.sessionId,
    required this.templateName,
    required this.startedAt,
    this.templateId,
  }) : super._();

  @override
  final String sessionId;
  @override
  final String templateName;
  @override
  final DateTime startedAt;
  @override
  final String? templateId;

  @override
  String toString() {
    return 'InProgressSessionInfo(sessionId: $sessionId, templateName: $templateName, startedAt: $startedAt, templateId: $templateId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InProgressSessionInfoImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.templateName, templateName) ||
                other.templateName == templateName) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, sessionId, templateName, startedAt, templateId);

  /// Create a copy of InProgressSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InProgressSessionInfoImplCopyWith<_$InProgressSessionInfoImpl>
  get copyWith =>
      __$$InProgressSessionInfoImplCopyWithImpl<_$InProgressSessionInfoImpl>(
        this,
        _$identity,
      );
}

abstract class _InProgressSessionInfo extends InProgressSessionInfo {
  const factory _InProgressSessionInfo({
    required final String sessionId,
    required final String templateName,
    required final DateTime startedAt,
    final String? templateId,
  }) = _$InProgressSessionInfoImpl;
  const _InProgressSessionInfo._() : super._();

  @override
  String get sessionId;
  @override
  String get templateName;
  @override
  DateTime get startedAt;
  @override
  String? get templateId;

  /// Create a copy of InProgressSessionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InProgressSessionInfoImplCopyWith<_$InProgressSessionInfoImpl>
  get copyWith => throw _privateConstructorUsedError;
}
