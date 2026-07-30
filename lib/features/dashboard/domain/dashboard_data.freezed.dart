// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DashboardData {
  AuthUser get user => throw _privateConstructorUsedError;
  List<Template> get activeTemplates => throw _privateConstructorUsedError;
  List<WorkoutSessionSummary> get recentSessions =>
      throw _privateConstructorUsedError;
  Consistency get consistency => throw _privateConstructorUsedError;

  /// Next session in the program order. See `DashboardController`.
  Template? get suggestedTemplate => throw _privateConstructorUsedError;
  InProgressSessionInfo? get inProgress => throw _privateConstructorUsedError;

  /// Create a copy of DashboardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardDataCopyWith<DashboardData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardDataCopyWith<$Res> {
  factory $DashboardDataCopyWith(
    DashboardData value,
    $Res Function(DashboardData) then,
  ) = _$DashboardDataCopyWithImpl<$Res, DashboardData>;
  @useResult
  $Res call({
    AuthUser user,
    List<Template> activeTemplates,
    List<WorkoutSessionSummary> recentSessions,
    Consistency consistency,
    Template? suggestedTemplate,
    InProgressSessionInfo? inProgress,
  });

  $AuthUserCopyWith<$Res> get user;
  $TemplateCopyWith<$Res>? get suggestedTemplate;
  $InProgressSessionInfoCopyWith<$Res>? get inProgress;
}

/// @nodoc
class _$DashboardDataCopyWithImpl<$Res, $Val extends DashboardData>
    implements $DashboardDataCopyWith<$Res> {
  _$DashboardDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? activeTemplates = null,
    Object? recentSessions = null,
    Object? consistency = null,
    Object? suggestedTemplate = freezed,
    Object? inProgress = freezed,
  }) {
    return _then(
      _value.copyWith(
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as AuthUser,
            activeTemplates: null == activeTemplates
                ? _value.activeTemplates
                : activeTemplates // ignore: cast_nullable_to_non_nullable
                      as List<Template>,
            recentSessions: null == recentSessions
                ? _value.recentSessions
                : recentSessions // ignore: cast_nullable_to_non_nullable
                      as List<WorkoutSessionSummary>,
            consistency: null == consistency
                ? _value.consistency
                : consistency // ignore: cast_nullable_to_non_nullable
                      as Consistency,
            suggestedTemplate: freezed == suggestedTemplate
                ? _value.suggestedTemplate
                : suggestedTemplate // ignore: cast_nullable_to_non_nullable
                      as Template?,
            inProgress: freezed == inProgress
                ? _value.inProgress
                : inProgress // ignore: cast_nullable_to_non_nullable
                      as InProgressSessionInfo?,
          )
          as $Val,
    );
  }

  /// Create a copy of DashboardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthUserCopyWith<$Res> get user {
    return $AuthUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of DashboardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TemplateCopyWith<$Res>? get suggestedTemplate {
    if (_value.suggestedTemplate == null) {
      return null;
    }

    return $TemplateCopyWith<$Res>(_value.suggestedTemplate!, (value) {
      return _then(_value.copyWith(suggestedTemplate: value) as $Val);
    });
  }

  /// Create a copy of DashboardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InProgressSessionInfoCopyWith<$Res>? get inProgress {
    if (_value.inProgress == null) {
      return null;
    }

    return $InProgressSessionInfoCopyWith<$Res>(_value.inProgress!, (value) {
      return _then(_value.copyWith(inProgress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardDataImplCopyWith<$Res>
    implements $DashboardDataCopyWith<$Res> {
  factory _$$DashboardDataImplCopyWith(
    _$DashboardDataImpl value,
    $Res Function(_$DashboardDataImpl) then,
  ) = __$$DashboardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AuthUser user,
    List<Template> activeTemplates,
    List<WorkoutSessionSummary> recentSessions,
    Consistency consistency,
    Template? suggestedTemplate,
    InProgressSessionInfo? inProgress,
  });

  @override
  $AuthUserCopyWith<$Res> get user;
  @override
  $TemplateCopyWith<$Res>? get suggestedTemplate;
  @override
  $InProgressSessionInfoCopyWith<$Res>? get inProgress;
}

/// @nodoc
class __$$DashboardDataImplCopyWithImpl<$Res>
    extends _$DashboardDataCopyWithImpl<$Res, _$DashboardDataImpl>
    implements _$$DashboardDataImplCopyWith<$Res> {
  __$$DashboardDataImplCopyWithImpl(
    _$DashboardDataImpl _value,
    $Res Function(_$DashboardDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? activeTemplates = null,
    Object? recentSessions = null,
    Object? consistency = null,
    Object? suggestedTemplate = freezed,
    Object? inProgress = freezed,
  }) {
    return _then(
      _$DashboardDataImpl(
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as AuthUser,
        activeTemplates: null == activeTemplates
            ? _value._activeTemplates
            : activeTemplates // ignore: cast_nullable_to_non_nullable
                  as List<Template>,
        recentSessions: null == recentSessions
            ? _value._recentSessions
            : recentSessions // ignore: cast_nullable_to_non_nullable
                  as List<WorkoutSessionSummary>,
        consistency: null == consistency
            ? _value.consistency
            : consistency // ignore: cast_nullable_to_non_nullable
                  as Consistency,
        suggestedTemplate: freezed == suggestedTemplate
            ? _value.suggestedTemplate
            : suggestedTemplate // ignore: cast_nullable_to_non_nullable
                  as Template?,
        inProgress: freezed == inProgress
            ? _value.inProgress
            : inProgress // ignore: cast_nullable_to_non_nullable
                  as InProgressSessionInfo?,
      ),
    );
  }
}

/// @nodoc

class _$DashboardDataImpl extends _DashboardData {
  const _$DashboardDataImpl({
    required this.user,
    required final List<Template> activeTemplates,
    required final List<WorkoutSessionSummary> recentSessions,
    required this.consistency,
    this.suggestedTemplate,
    this.inProgress,
  }) : _activeTemplates = activeTemplates,
       _recentSessions = recentSessions,
       super._();

  @override
  final AuthUser user;
  final List<Template> _activeTemplates;
  @override
  List<Template> get activeTemplates {
    if (_activeTemplates is EqualUnmodifiableListView) return _activeTemplates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeTemplates);
  }

  final List<WorkoutSessionSummary> _recentSessions;
  @override
  List<WorkoutSessionSummary> get recentSessions {
    if (_recentSessions is EqualUnmodifiableListView) return _recentSessions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentSessions);
  }

  @override
  final Consistency consistency;

  /// Next session in the program order. See `DashboardController`.
  @override
  final Template? suggestedTemplate;
  @override
  final InProgressSessionInfo? inProgress;

  @override
  String toString() {
    return 'DashboardData(user: $user, activeTemplates: $activeTemplates, recentSessions: $recentSessions, consistency: $consistency, suggestedTemplate: $suggestedTemplate, inProgress: $inProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardDataImpl &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality().equals(
              other._activeTemplates,
              _activeTemplates,
            ) &&
            const DeepCollectionEquality().equals(
              other._recentSessions,
              _recentSessions,
            ) &&
            (identical(other.consistency, consistency) ||
                other.consistency == consistency) &&
            (identical(other.suggestedTemplate, suggestedTemplate) ||
                other.suggestedTemplate == suggestedTemplate) &&
            (identical(other.inProgress, inProgress) ||
                other.inProgress == inProgress));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    user,
    const DeepCollectionEquality().hash(_activeTemplates),
    const DeepCollectionEquality().hash(_recentSessions),
    consistency,
    suggestedTemplate,
    inProgress,
  );

  /// Create a copy of DashboardData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardDataImplCopyWith<_$DashboardDataImpl> get copyWith =>
      __$$DashboardDataImplCopyWithImpl<_$DashboardDataImpl>(this, _$identity);
}

abstract class _DashboardData extends DashboardData {
  const factory _DashboardData({
    required final AuthUser user,
    required final List<Template> activeTemplates,
    required final List<WorkoutSessionSummary> recentSessions,
    required final Consistency consistency,
    final Template? suggestedTemplate,
    final InProgressSessionInfo? inProgress,
  }) = _$DashboardDataImpl;
  const _DashboardData._() : super._();

  @override
  AuthUser get user;
  @override
  List<Template> get activeTemplates;
  @override
  List<WorkoutSessionSummary> get recentSessions;
  @override
  Consistency get consistency;

  /// Next session in the program order. See `DashboardController`.
  @override
  Template? get suggestedTemplate;
  @override
  InProgressSessionInfo? get inProgress;

  /// Create a copy of DashboardData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardDataImplCopyWith<_$DashboardDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
