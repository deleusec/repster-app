// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_session_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkoutSessionSummary {
  String get id => throw _privateConstructorUsedError;
  String get templateName => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  int get durationSeconds => throw _privateConstructorUsedError;
  double get totalTonnageKg => throw _privateConstructorUsedError;
  int get totalSets => throw _privateConstructorUsedError;
  List<MuscleGroup> get tags => throw _privateConstructorUsedError;

  /// Seconds held on time-based exercises. Kept apart from the tonnage:
  /// seconds and reps are not the same unit.
  int get timeUnderTensionSec => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutSessionSummaryCopyWith<WorkoutSessionSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutSessionSummaryCopyWith<$Res> {
  factory $WorkoutSessionSummaryCopyWith(
    WorkoutSessionSummary value,
    $Res Function(WorkoutSessionSummary) then,
  ) = _$WorkoutSessionSummaryCopyWithImpl<$Res, WorkoutSessionSummary>;
  @useResult
  $Res call({
    String id,
    String templateName,
    DateTime startedAt,
    int durationSeconds,
    double totalTonnageKg,
    int totalSets,
    List<MuscleGroup> tags,
    int timeUnderTensionSec,
  });
}

/// @nodoc
class _$WorkoutSessionSummaryCopyWithImpl<
  $Res,
  $Val extends WorkoutSessionSummary
>
    implements $WorkoutSessionSummaryCopyWith<$Res> {
  _$WorkoutSessionSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? templateName = null,
    Object? startedAt = null,
    Object? durationSeconds = null,
    Object? totalTonnageKg = null,
    Object? totalSets = null,
    Object? tags = null,
    Object? timeUnderTensionSec = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            templateName: null == templateName
                ? _value.templateName
                : templateName // ignore: cast_nullable_to_non_nullable
                      as String,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            durationSeconds: null == durationSeconds
                ? _value.durationSeconds
                : durationSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            totalTonnageKg: null == totalTonnageKg
                ? _value.totalTonnageKg
                : totalTonnageKg // ignore: cast_nullable_to_non_nullable
                      as double,
            totalSets: null == totalSets
                ? _value.totalSets
                : totalSets // ignore: cast_nullable_to_non_nullable
                      as int,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<MuscleGroup>,
            timeUnderTensionSec: null == timeUnderTensionSec
                ? _value.timeUnderTensionSec
                : timeUnderTensionSec // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkoutSessionSummaryImplCopyWith<$Res>
    implements $WorkoutSessionSummaryCopyWith<$Res> {
  factory _$$WorkoutSessionSummaryImplCopyWith(
    _$WorkoutSessionSummaryImpl value,
    $Res Function(_$WorkoutSessionSummaryImpl) then,
  ) = __$$WorkoutSessionSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String templateName,
    DateTime startedAt,
    int durationSeconds,
    double totalTonnageKg,
    int totalSets,
    List<MuscleGroup> tags,
    int timeUnderTensionSec,
  });
}

/// @nodoc
class __$$WorkoutSessionSummaryImplCopyWithImpl<$Res>
    extends
        _$WorkoutSessionSummaryCopyWithImpl<$Res, _$WorkoutSessionSummaryImpl>
    implements _$$WorkoutSessionSummaryImplCopyWith<$Res> {
  __$$WorkoutSessionSummaryImplCopyWithImpl(
    _$WorkoutSessionSummaryImpl _value,
    $Res Function(_$WorkoutSessionSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? templateName = null,
    Object? startedAt = null,
    Object? durationSeconds = null,
    Object? totalTonnageKg = null,
    Object? totalSets = null,
    Object? tags = null,
    Object? timeUnderTensionSec = null,
  }) {
    return _then(
      _$WorkoutSessionSummaryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        templateName: null == templateName
            ? _value.templateName
            : templateName // ignore: cast_nullable_to_non_nullable
                  as String,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        durationSeconds: null == durationSeconds
            ? _value.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        totalTonnageKg: null == totalTonnageKg
            ? _value.totalTonnageKg
            : totalTonnageKg // ignore: cast_nullable_to_non_nullable
                  as double,
        totalSets: null == totalSets
            ? _value.totalSets
            : totalSets // ignore: cast_nullable_to_non_nullable
                  as int,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<MuscleGroup>,
        timeUnderTensionSec: null == timeUnderTensionSec
            ? _value.timeUnderTensionSec
            : timeUnderTensionSec // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$WorkoutSessionSummaryImpl extends _WorkoutSessionSummary {
  const _$WorkoutSessionSummaryImpl({
    required this.id,
    required this.templateName,
    required this.startedAt,
    required this.durationSeconds,
    required this.totalTonnageKg,
    required this.totalSets,
    required final List<MuscleGroup> tags,
    this.timeUnderTensionSec = 0,
  }) : _tags = tags,
       super._();

  @override
  final String id;
  @override
  final String templateName;
  @override
  final DateTime startedAt;
  @override
  final int durationSeconds;
  @override
  final double totalTonnageKg;
  @override
  final int totalSets;
  final List<MuscleGroup> _tags;
  @override
  List<MuscleGroup> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// Seconds held on time-based exercises. Kept apart from the tonnage:
  /// seconds and reps are not the same unit.
  @override
  @JsonKey()
  final int timeUnderTensionSec;

  @override
  String toString() {
    return 'WorkoutSessionSummary(id: $id, templateName: $templateName, startedAt: $startedAt, durationSeconds: $durationSeconds, totalTonnageKg: $totalTonnageKg, totalSets: $totalSets, tags: $tags, timeUnderTensionSec: $timeUnderTensionSec)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSessionSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.templateName, templateName) ||
                other.templateName == templateName) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.totalTonnageKg, totalTonnageKg) ||
                other.totalTonnageKg == totalTonnageKg) &&
            (identical(other.totalSets, totalSets) ||
                other.totalSets == totalSets) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.timeUnderTensionSec, timeUnderTensionSec) ||
                other.timeUnderTensionSec == timeUnderTensionSec));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    templateName,
    startedAt,
    durationSeconds,
    totalTonnageKg,
    totalSets,
    const DeepCollectionEquality().hash(_tags),
    timeUnderTensionSec,
  );

  /// Create a copy of WorkoutSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutSessionSummaryImplCopyWith<_$WorkoutSessionSummaryImpl>
  get copyWith =>
      __$$WorkoutSessionSummaryImplCopyWithImpl<_$WorkoutSessionSummaryImpl>(
        this,
        _$identity,
      );
}

abstract class _WorkoutSessionSummary extends WorkoutSessionSummary {
  const factory _WorkoutSessionSummary({
    required final String id,
    required final String templateName,
    required final DateTime startedAt,
    required final int durationSeconds,
    required final double totalTonnageKg,
    required final int totalSets,
    required final List<MuscleGroup> tags,
    final int timeUnderTensionSec,
  }) = _$WorkoutSessionSummaryImpl;
  const _WorkoutSessionSummary._() : super._();

  @override
  String get id;
  @override
  String get templateName;
  @override
  DateTime get startedAt;
  @override
  int get durationSeconds;
  @override
  double get totalTonnageKg;
  @override
  int get totalSets;
  @override
  List<MuscleGroup> get tags;

  /// Seconds held on time-based exercises. Kept apart from the tonnage:
  /// seconds and reps are not the same unit.
  @override
  int get timeUnderTensionSec;

  /// Create a copy of WorkoutSessionSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutSessionSummaryImplCopyWith<_$WorkoutSessionSummaryImpl>
  get copyWith => throw _privateConstructorUsedError;
}
