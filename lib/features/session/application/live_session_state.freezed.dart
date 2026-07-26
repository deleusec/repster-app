// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LiveSessionState {
  LiveSessionStatus get status => throw _privateConstructorUsedError;
  int get currentExerciseIndex => throw _privateConstructorUsedError;

  /// Latest perfs keyed by `name:target`, one entry per set.
  Map<String, List<LastPerf>> get lastPerfs =>
      throw _privateConstructorUsedError;
  Map<String, LastPerfMeta> get lastPerfsMeta =>
      throw _privateConstructorUsedError;
  bool get isResting => throw _privateConstructorUsedError;
  DateTime? get restStartedAt => throw _privateConstructorUsedError;
  int get restTotalSeconds => throw _privateConstructorUsedError;

  /// Exercise index to return to when rest ends (back to the first exercise
  /// of a superset block at the start of the next round).
  int? get restReturnTo => throw _privateConstructorUsedError;
  WorkoutSession? get session => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Active time from segments already closed, in seconds. Only grows, when
  /// an action resumes a session that had gone idle.
  int get bankedSeconds => throw _privateConstructorUsedError;

  /// Start of the open segment — the session's start, or the first action
  /// after an idle gap. `null` before the session starts.
  DateTime? get segmentStartedAt => throw _privateConstructorUsedError;

  /// Last action performed in the session (a validated set, a changed load,
  /// an added exercise…). `null` before the session starts.
  DateTime? get lastActivityAt => throw _privateConstructorUsedError;

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LiveSessionStateCopyWith<LiveSessionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveSessionStateCopyWith<$Res> {
  factory $LiveSessionStateCopyWith(
    LiveSessionState value,
    $Res Function(LiveSessionState) then,
  ) = _$LiveSessionStateCopyWithImpl<$Res, LiveSessionState>;
  @useResult
  $Res call({
    LiveSessionStatus status,
    int currentExerciseIndex,
    Map<String, List<LastPerf>> lastPerfs,
    Map<String, LastPerfMeta> lastPerfsMeta,
    bool isResting,
    DateTime? restStartedAt,
    int restTotalSeconds,
    int? restReturnTo,
    WorkoutSession? session,
    String? error,
    int bankedSeconds,
    DateTime? segmentStartedAt,
    DateTime? lastActivityAt,
  });

  $WorkoutSessionCopyWith<$Res>? get session;
}

/// @nodoc
class _$LiveSessionStateCopyWithImpl<$Res, $Val extends LiveSessionState>
    implements $LiveSessionStateCopyWith<$Res> {
  _$LiveSessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentExerciseIndex = null,
    Object? lastPerfs = null,
    Object? lastPerfsMeta = null,
    Object? isResting = null,
    Object? restStartedAt = freezed,
    Object? restTotalSeconds = null,
    Object? restReturnTo = freezed,
    Object? session = freezed,
    Object? error = freezed,
    Object? bankedSeconds = null,
    Object? segmentStartedAt = freezed,
    Object? lastActivityAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as LiveSessionStatus,
            currentExerciseIndex: null == currentExerciseIndex
                ? _value.currentExerciseIndex
                : currentExerciseIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            lastPerfs: null == lastPerfs
                ? _value.lastPerfs
                : lastPerfs // ignore: cast_nullable_to_non_nullable
                      as Map<String, List<LastPerf>>,
            lastPerfsMeta: null == lastPerfsMeta
                ? _value.lastPerfsMeta
                : lastPerfsMeta // ignore: cast_nullable_to_non_nullable
                      as Map<String, LastPerfMeta>,
            isResting: null == isResting
                ? _value.isResting
                : isResting // ignore: cast_nullable_to_non_nullable
                      as bool,
            restStartedAt: freezed == restStartedAt
                ? _value.restStartedAt
                : restStartedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            restTotalSeconds: null == restTotalSeconds
                ? _value.restTotalSeconds
                : restTotalSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            restReturnTo: freezed == restReturnTo
                ? _value.restReturnTo
                : restReturnTo // ignore: cast_nullable_to_non_nullable
                      as int?,
            session: freezed == session
                ? _value.session
                : session // ignore: cast_nullable_to_non_nullable
                      as WorkoutSession?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            bankedSeconds: null == bankedSeconds
                ? _value.bankedSeconds
                : bankedSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            segmentStartedAt: freezed == segmentStartedAt
                ? _value.segmentStartedAt
                : segmentStartedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastActivityAt: freezed == lastActivityAt
                ? _value.lastActivityAt
                : lastActivityAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutSessionCopyWith<$Res>? get session {
    if (_value.session == null) {
      return null;
    }

    return $WorkoutSessionCopyWith<$Res>(_value.session!, (value) {
      return _then(_value.copyWith(session: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LiveSessionStateImplCopyWith<$Res>
    implements $LiveSessionStateCopyWith<$Res> {
  factory _$$LiveSessionStateImplCopyWith(
    _$LiveSessionStateImpl value,
    $Res Function(_$LiveSessionStateImpl) then,
  ) = __$$LiveSessionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LiveSessionStatus status,
    int currentExerciseIndex,
    Map<String, List<LastPerf>> lastPerfs,
    Map<String, LastPerfMeta> lastPerfsMeta,
    bool isResting,
    DateTime? restStartedAt,
    int restTotalSeconds,
    int? restReturnTo,
    WorkoutSession? session,
    String? error,
    int bankedSeconds,
    DateTime? segmentStartedAt,
    DateTime? lastActivityAt,
  });

  @override
  $WorkoutSessionCopyWith<$Res>? get session;
}

/// @nodoc
class __$$LiveSessionStateImplCopyWithImpl<$Res>
    extends _$LiveSessionStateCopyWithImpl<$Res, _$LiveSessionStateImpl>
    implements _$$LiveSessionStateImplCopyWith<$Res> {
  __$$LiveSessionStateImplCopyWithImpl(
    _$LiveSessionStateImpl _value,
    $Res Function(_$LiveSessionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentExerciseIndex = null,
    Object? lastPerfs = null,
    Object? lastPerfsMeta = null,
    Object? isResting = null,
    Object? restStartedAt = freezed,
    Object? restTotalSeconds = null,
    Object? restReturnTo = freezed,
    Object? session = freezed,
    Object? error = freezed,
    Object? bankedSeconds = null,
    Object? segmentStartedAt = freezed,
    Object? lastActivityAt = freezed,
  }) {
    return _then(
      _$LiveSessionStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as LiveSessionStatus,
        currentExerciseIndex: null == currentExerciseIndex
            ? _value.currentExerciseIndex
            : currentExerciseIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        lastPerfs: null == lastPerfs
            ? _value._lastPerfs
            : lastPerfs // ignore: cast_nullable_to_non_nullable
                  as Map<String, List<LastPerf>>,
        lastPerfsMeta: null == lastPerfsMeta
            ? _value._lastPerfsMeta
            : lastPerfsMeta // ignore: cast_nullable_to_non_nullable
                  as Map<String, LastPerfMeta>,
        isResting: null == isResting
            ? _value.isResting
            : isResting // ignore: cast_nullable_to_non_nullable
                  as bool,
        restStartedAt: freezed == restStartedAt
            ? _value.restStartedAt
            : restStartedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        restTotalSeconds: null == restTotalSeconds
            ? _value.restTotalSeconds
            : restTotalSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        restReturnTo: freezed == restReturnTo
            ? _value.restReturnTo
            : restReturnTo // ignore: cast_nullable_to_non_nullable
                  as int?,
        session: freezed == session
            ? _value.session
            : session // ignore: cast_nullable_to_non_nullable
                  as WorkoutSession?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        bankedSeconds: null == bankedSeconds
            ? _value.bankedSeconds
            : bankedSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        segmentStartedAt: freezed == segmentStartedAt
            ? _value.segmentStartedAt
            : segmentStartedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastActivityAt: freezed == lastActivityAt
            ? _value.lastActivityAt
            : lastActivityAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$LiveSessionStateImpl extends _LiveSessionState {
  const _$LiveSessionStateImpl({
    required this.status,
    required this.currentExerciseIndex,
    required final Map<String, List<LastPerf>> lastPerfs,
    required final Map<String, LastPerfMeta> lastPerfsMeta,
    this.isResting = false,
    this.restStartedAt,
    this.restTotalSeconds = 0,
    this.restReturnTo,
    this.session,
    this.error,
    this.bankedSeconds = 0,
    this.segmentStartedAt,
    this.lastActivityAt,
  }) : _lastPerfs = lastPerfs,
       _lastPerfsMeta = lastPerfsMeta,
       super._();

  @override
  final LiveSessionStatus status;
  @override
  final int currentExerciseIndex;

  /// Latest perfs keyed by `name:target`, one entry per set.
  final Map<String, List<LastPerf>> _lastPerfs;

  /// Latest perfs keyed by `name:target`, one entry per set.
  @override
  Map<String, List<LastPerf>> get lastPerfs {
    if (_lastPerfs is EqualUnmodifiableMapView) return _lastPerfs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lastPerfs);
  }

  final Map<String, LastPerfMeta> _lastPerfsMeta;
  @override
  Map<String, LastPerfMeta> get lastPerfsMeta {
    if (_lastPerfsMeta is EqualUnmodifiableMapView) return _lastPerfsMeta;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_lastPerfsMeta);
  }

  @override
  @JsonKey()
  final bool isResting;
  @override
  final DateTime? restStartedAt;
  @override
  @JsonKey()
  final int restTotalSeconds;

  /// Exercise index to return to when rest ends (back to the first exercise
  /// of a superset block at the start of the next round).
  @override
  final int? restReturnTo;
  @override
  final WorkoutSession? session;
  @override
  final String? error;

  /// Active time from segments already closed, in seconds. Only grows, when
  /// an action resumes a session that had gone idle.
  @override
  @JsonKey()
  final int bankedSeconds;

  /// Start of the open segment — the session's start, or the first action
  /// after an idle gap. `null` before the session starts.
  @override
  final DateTime? segmentStartedAt;

  /// Last action performed in the session (a validated set, a changed load,
  /// an added exercise…). `null` before the session starts.
  @override
  final DateTime? lastActivityAt;

  @override
  String toString() {
    return 'LiveSessionState(status: $status, currentExerciseIndex: $currentExerciseIndex, lastPerfs: $lastPerfs, lastPerfsMeta: $lastPerfsMeta, isResting: $isResting, restStartedAt: $restStartedAt, restTotalSeconds: $restTotalSeconds, restReturnTo: $restReturnTo, session: $session, error: $error, bankedSeconds: $bankedSeconds, segmentStartedAt: $segmentStartedAt, lastActivityAt: $lastActivityAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveSessionStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentExerciseIndex, currentExerciseIndex) ||
                other.currentExerciseIndex == currentExerciseIndex) &&
            const DeepCollectionEquality().equals(
              other._lastPerfs,
              _lastPerfs,
            ) &&
            const DeepCollectionEquality().equals(
              other._lastPerfsMeta,
              _lastPerfsMeta,
            ) &&
            (identical(other.isResting, isResting) ||
                other.isResting == isResting) &&
            (identical(other.restStartedAt, restStartedAt) ||
                other.restStartedAt == restStartedAt) &&
            (identical(other.restTotalSeconds, restTotalSeconds) ||
                other.restTotalSeconds == restTotalSeconds) &&
            (identical(other.restReturnTo, restReturnTo) ||
                other.restReturnTo == restReturnTo) &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.bankedSeconds, bankedSeconds) ||
                other.bankedSeconds == bankedSeconds) &&
            (identical(other.segmentStartedAt, segmentStartedAt) ||
                other.segmentStartedAt == segmentStartedAt) &&
            (identical(other.lastActivityAt, lastActivityAt) ||
                other.lastActivityAt == lastActivityAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    currentExerciseIndex,
    const DeepCollectionEquality().hash(_lastPerfs),
    const DeepCollectionEquality().hash(_lastPerfsMeta),
    isResting,
    restStartedAt,
    restTotalSeconds,
    restReturnTo,
    session,
    error,
    bankedSeconds,
    segmentStartedAt,
    lastActivityAt,
  );

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveSessionStateImplCopyWith<_$LiveSessionStateImpl> get copyWith =>
      __$$LiveSessionStateImplCopyWithImpl<_$LiveSessionStateImpl>(
        this,
        _$identity,
      );
}

abstract class _LiveSessionState extends LiveSessionState {
  const factory _LiveSessionState({
    required final LiveSessionStatus status,
    required final int currentExerciseIndex,
    required final Map<String, List<LastPerf>> lastPerfs,
    required final Map<String, LastPerfMeta> lastPerfsMeta,
    final bool isResting,
    final DateTime? restStartedAt,
    final int restTotalSeconds,
    final int? restReturnTo,
    final WorkoutSession? session,
    final String? error,
    final int bankedSeconds,
    final DateTime? segmentStartedAt,
    final DateTime? lastActivityAt,
  }) = _$LiveSessionStateImpl;
  const _LiveSessionState._() : super._();

  @override
  LiveSessionStatus get status;
  @override
  int get currentExerciseIndex;

  /// Latest perfs keyed by `name:target`, one entry per set.
  @override
  Map<String, List<LastPerf>> get lastPerfs;
  @override
  Map<String, LastPerfMeta> get lastPerfsMeta;
  @override
  bool get isResting;
  @override
  DateTime? get restStartedAt;
  @override
  int get restTotalSeconds;

  /// Exercise index to return to when rest ends (back to the first exercise
  /// of a superset block at the start of the next round).
  @override
  int? get restReturnTo;
  @override
  WorkoutSession? get session;
  @override
  String? get error;

  /// Active time from segments already closed, in seconds. Only grows, when
  /// an action resumes a session that had gone idle.
  @override
  int get bankedSeconds;

  /// Start of the open segment — the session's start, or the first action
  /// after an idle gap. `null` before the session starts.
  @override
  DateTime? get segmentStartedAt;

  /// Last action performed in the session (a validated set, a changed load,
  /// an added exercise…). `null` before the session starts.
  @override
  DateTime? get lastActivityAt;

  /// Create a copy of LiveSessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LiveSessionStateImplCopyWith<_$LiveSessionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
