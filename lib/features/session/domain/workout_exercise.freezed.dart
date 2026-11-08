// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorkoutVariant _$WorkoutVariantFromJson(Map<String, dynamic> json) {
  return _WorkoutVariant.fromJson(json);
}

/// @nodoc
mixin _$WorkoutVariant {
  String get name => throw _privateConstructorUsedError;
  int get sets => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  String get tempo => throw _privateConstructorUsedError;
  int get restTime => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  bool get isTimeBased => throw _privateConstructorUsedError;
  int? get durationSeconds => throw _privateConstructorUsedError;
  String? get exerciseId => throw _privateConstructorUsedError;

  /// Serializes this WorkoutVariant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutVariant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutVariantCopyWith<WorkoutVariant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutVariantCopyWith<$Res> {
  factory $WorkoutVariantCopyWith(
    WorkoutVariant value,
    $Res Function(WorkoutVariant) then,
  ) = _$WorkoutVariantCopyWithImpl<$Res, WorkoutVariant>;
  @useResult
  $Res call({
    String name,
    int sets,
    int reps,
    String tempo,
    int restTime,
    String notes,
    bool isTimeBased,
    int? durationSeconds,
    String? exerciseId,
  });
}

/// @nodoc
class _$WorkoutVariantCopyWithImpl<$Res, $Val extends WorkoutVariant>
    implements $WorkoutVariantCopyWith<$Res> {
  _$WorkoutVariantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutVariant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? sets = null,
    Object? reps = null,
    Object? tempo = null,
    Object? restTime = null,
    Object? notes = null,
    Object? isTimeBased = null,
    Object? durationSeconds = freezed,
    Object? exerciseId = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            sets: null == sets
                ? _value.sets
                : sets // ignore: cast_nullable_to_non_nullable
                      as int,
            reps: null == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                      as int,
            tempo: null == tempo
                ? _value.tempo
                : tempo // ignore: cast_nullable_to_non_nullable
                      as String,
            restTime: null == restTime
                ? _value.restTime
                : restTime // ignore: cast_nullable_to_non_nullable
                      as int,
            notes: null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String,
            isTimeBased: null == isTimeBased
                ? _value.isTimeBased
                : isTimeBased // ignore: cast_nullable_to_non_nullable
                      as bool,
            durationSeconds: freezed == durationSeconds
                ? _value.durationSeconds
                : durationSeconds // ignore: cast_nullable_to_non_nullable
                      as int?,
            exerciseId: freezed == exerciseId
                ? _value.exerciseId
                : exerciseId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkoutVariantImplCopyWith<$Res>
    implements $WorkoutVariantCopyWith<$Res> {
  factory _$$WorkoutVariantImplCopyWith(
    _$WorkoutVariantImpl value,
    $Res Function(_$WorkoutVariantImpl) then,
  ) = __$$WorkoutVariantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    int sets,
    int reps,
    String tempo,
    int restTime,
    String notes,
    bool isTimeBased,
    int? durationSeconds,
    String? exerciseId,
  });
}

/// @nodoc
class __$$WorkoutVariantImplCopyWithImpl<$Res>
    extends _$WorkoutVariantCopyWithImpl<$Res, _$WorkoutVariantImpl>
    implements _$$WorkoutVariantImplCopyWith<$Res> {
  __$$WorkoutVariantImplCopyWithImpl(
    _$WorkoutVariantImpl _value,
    $Res Function(_$WorkoutVariantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutVariant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? sets = null,
    Object? reps = null,
    Object? tempo = null,
    Object? restTime = null,
    Object? notes = null,
    Object? isTimeBased = null,
    Object? durationSeconds = freezed,
    Object? exerciseId = freezed,
  }) {
    return _then(
      _$WorkoutVariantImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        sets: null == sets
            ? _value.sets
            : sets // ignore: cast_nullable_to_non_nullable
                  as int,
        reps: null == reps
            ? _value.reps
            : reps // ignore: cast_nullable_to_non_nullable
                  as int,
        tempo: null == tempo
            ? _value.tempo
            : tempo // ignore: cast_nullable_to_non_nullable
                  as String,
        restTime: null == restTime
            ? _value.restTime
            : restTime // ignore: cast_nullable_to_non_nullable
                  as int,
        notes: null == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String,
        isTimeBased: null == isTimeBased
            ? _value.isTimeBased
            : isTimeBased // ignore: cast_nullable_to_non_nullable
                  as bool,
        durationSeconds: freezed == durationSeconds
            ? _value.durationSeconds
            : durationSeconds // ignore: cast_nullable_to_non_nullable
                  as int?,
        exerciseId: freezed == exerciseId
            ? _value.exerciseId
            : exerciseId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutVariantImpl extends _WorkoutVariant {
  const _$WorkoutVariantImpl({
    required this.name,
    required this.sets,
    required this.reps,
    required this.tempo,
    required this.restTime,
    required this.notes,
    this.isTimeBased = false,
    this.durationSeconds,
    this.exerciseId,
  }) : super._();

  factory _$WorkoutVariantImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutVariantImplFromJson(json);

  @override
  final String name;
  @override
  final int sets;
  @override
  final int reps;
  @override
  final String tempo;
  @override
  final int restTime;
  @override
  final String notes;
  @override
  @JsonKey()
  final bool isTimeBased;
  @override
  final int? durationSeconds;
  @override
  final String? exerciseId;

  @override
  String toString() {
    return 'WorkoutVariant(name: $name, sets: $sets, reps: $reps, tempo: $tempo, restTime: $restTime, notes: $notes, isTimeBased: $isTimeBased, durationSeconds: $durationSeconds, exerciseId: $exerciseId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutVariantImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sets, sets) || other.sets == sets) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.tempo, tempo) || other.tempo == tempo) &&
            (identical(other.restTime, restTime) ||
                other.restTime == restTime) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.isTimeBased, isTimeBased) ||
                other.isTimeBased == isTimeBased) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    sets,
    reps,
    tempo,
    restTime,
    notes,
    isTimeBased,
    durationSeconds,
    exerciseId,
  );

  /// Create a copy of WorkoutVariant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutVariantImplCopyWith<_$WorkoutVariantImpl> get copyWith =>
      __$$WorkoutVariantImplCopyWithImpl<_$WorkoutVariantImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutVariantImplToJson(this);
  }
}

abstract class _WorkoutVariant extends WorkoutVariant {
  const factory _WorkoutVariant({
    required final String name,
    required final int sets,
    required final int reps,
    required final String tempo,
    required final int restTime,
    required final String notes,
    final bool isTimeBased,
    final int? durationSeconds,
    final String? exerciseId,
  }) = _$WorkoutVariantImpl;
  const _WorkoutVariant._() : super._();

  factory _WorkoutVariant.fromJson(Map<String, dynamic> json) =
      _$WorkoutVariantImpl.fromJson;

  @override
  String get name;
  @override
  int get sets;
  @override
  int get reps;
  @override
  String get tempo;
  @override
  int get restTime;
  @override
  String get notes;
  @override
  bool get isTimeBased;
  @override
  int? get durationSeconds;
  @override
  String? get exerciseId;

  /// Create a copy of WorkoutVariant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutVariantImplCopyWith<_$WorkoutVariantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkoutExercise _$WorkoutExerciseFromJson(Map<String, dynamic> json) {
  return _WorkoutExercise.fromJson(json);
}

/// @nodoc
mixin _$WorkoutExercise {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  String get tempo => throw _privateConstructorUsedError;
  int get restTime => throw _privateConstructorUsedError;
  List<WorkoutSet> get sets => throw _privateConstructorUsedError;
  bool get isTimeBased => throw _privateConstructorUsedError;

  /// Catalog identity, when known. `null` for an exercise typed by hand in
  /// session — the history lookup then falls back to the normalized name.
  String? get exerciseId => throw _privateConstructorUsedError;
  String? get slotId => throw _privateConstructorUsedError;
  String? get originalName => throw _privateConstructorUsedError;
  bool get sessionModified => throw _privateConstructorUsedError;

  /// The user asked for this exercise, as it now stands, to be written back
  /// to the template when the session ends. Off by default: a change made
  /// mid-session is for today only unless said otherwise.
  bool get keepInTemplate => throw _privateConstructorUsedError;
  List<WorkoutVariant>? get variants => throw _privateConstructorUsedError;
  int? get activeVariantIndex => throw _privateConstructorUsedError;
  String? get supersetGroupId => throw _privateConstructorUsedError;
  int? get supersetPosition => throw _privateConstructorUsedError;
  int? get supersetSize => throw _privateConstructorUsedError;

  /// Serializes this WorkoutExercise to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutExerciseCopyWith<WorkoutExercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutExerciseCopyWith<$Res> {
  factory $WorkoutExerciseCopyWith(
    WorkoutExercise value,
    $Res Function(WorkoutExercise) then,
  ) = _$WorkoutExerciseCopyWithImpl<$Res, WorkoutExercise>;
  @useResult
  $Res call({
    String id,
    String name,
    String notes,
    String tempo,
    int restTime,
    List<WorkoutSet> sets,
    bool isTimeBased,
    String? exerciseId,
    String? slotId,
    String? originalName,
    bool sessionModified,
    bool keepInTemplate,
    List<WorkoutVariant>? variants,
    int? activeVariantIndex,
    String? supersetGroupId,
    int? supersetPosition,
    int? supersetSize,
  });
}

/// @nodoc
class _$WorkoutExerciseCopyWithImpl<$Res, $Val extends WorkoutExercise>
    implements $WorkoutExerciseCopyWith<$Res> {
  _$WorkoutExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? notes = null,
    Object? tempo = null,
    Object? restTime = null,
    Object? sets = null,
    Object? isTimeBased = null,
    Object? exerciseId = freezed,
    Object? slotId = freezed,
    Object? originalName = freezed,
    Object? sessionModified = null,
    Object? keepInTemplate = null,
    Object? variants = freezed,
    Object? activeVariantIndex = freezed,
    Object? supersetGroupId = freezed,
    Object? supersetPosition = freezed,
    Object? supersetSize = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            notes: null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String,
            tempo: null == tempo
                ? _value.tempo
                : tempo // ignore: cast_nullable_to_non_nullable
                      as String,
            restTime: null == restTime
                ? _value.restTime
                : restTime // ignore: cast_nullable_to_non_nullable
                      as int,
            sets: null == sets
                ? _value.sets
                : sets // ignore: cast_nullable_to_non_nullable
                      as List<WorkoutSet>,
            isTimeBased: null == isTimeBased
                ? _value.isTimeBased
                : isTimeBased // ignore: cast_nullable_to_non_nullable
                      as bool,
            exerciseId: freezed == exerciseId
                ? _value.exerciseId
                : exerciseId // ignore: cast_nullable_to_non_nullable
                      as String?,
            slotId: freezed == slotId
                ? _value.slotId
                : slotId // ignore: cast_nullable_to_non_nullable
                      as String?,
            originalName: freezed == originalName
                ? _value.originalName
                : originalName // ignore: cast_nullable_to_non_nullable
                      as String?,
            sessionModified: null == sessionModified
                ? _value.sessionModified
                : sessionModified // ignore: cast_nullable_to_non_nullable
                      as bool,
            keepInTemplate: null == keepInTemplate
                ? _value.keepInTemplate
                : keepInTemplate // ignore: cast_nullable_to_non_nullable
                      as bool,
            variants: freezed == variants
                ? _value.variants
                : variants // ignore: cast_nullable_to_non_nullable
                      as List<WorkoutVariant>?,
            activeVariantIndex: freezed == activeVariantIndex
                ? _value.activeVariantIndex
                : activeVariantIndex // ignore: cast_nullable_to_non_nullable
                      as int?,
            supersetGroupId: freezed == supersetGroupId
                ? _value.supersetGroupId
                : supersetGroupId // ignore: cast_nullable_to_non_nullable
                      as String?,
            supersetPosition: freezed == supersetPosition
                ? _value.supersetPosition
                : supersetPosition // ignore: cast_nullable_to_non_nullable
                      as int?,
            supersetSize: freezed == supersetSize
                ? _value.supersetSize
                : supersetSize // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkoutExerciseImplCopyWith<$Res>
    implements $WorkoutExerciseCopyWith<$Res> {
  factory _$$WorkoutExerciseImplCopyWith(
    _$WorkoutExerciseImpl value,
    $Res Function(_$WorkoutExerciseImpl) then,
  ) = __$$WorkoutExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String notes,
    String tempo,
    int restTime,
    List<WorkoutSet> sets,
    bool isTimeBased,
    String? exerciseId,
    String? slotId,
    String? originalName,
    bool sessionModified,
    bool keepInTemplate,
    List<WorkoutVariant>? variants,
    int? activeVariantIndex,
    String? supersetGroupId,
    int? supersetPosition,
    int? supersetSize,
  });
}

/// @nodoc
class __$$WorkoutExerciseImplCopyWithImpl<$Res>
    extends _$WorkoutExerciseCopyWithImpl<$Res, _$WorkoutExerciseImpl>
    implements _$$WorkoutExerciseImplCopyWith<$Res> {
  __$$WorkoutExerciseImplCopyWithImpl(
    _$WorkoutExerciseImpl _value,
    $Res Function(_$WorkoutExerciseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? notes = null,
    Object? tempo = null,
    Object? restTime = null,
    Object? sets = null,
    Object? isTimeBased = null,
    Object? exerciseId = freezed,
    Object? slotId = freezed,
    Object? originalName = freezed,
    Object? sessionModified = null,
    Object? keepInTemplate = null,
    Object? variants = freezed,
    Object? activeVariantIndex = freezed,
    Object? supersetGroupId = freezed,
    Object? supersetPosition = freezed,
    Object? supersetSize = freezed,
  }) {
    return _then(
      _$WorkoutExerciseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        notes: null == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String,
        tempo: null == tempo
            ? _value.tempo
            : tempo // ignore: cast_nullable_to_non_nullable
                  as String,
        restTime: null == restTime
            ? _value.restTime
            : restTime // ignore: cast_nullable_to_non_nullable
                  as int,
        sets: null == sets
            ? _value._sets
            : sets // ignore: cast_nullable_to_non_nullable
                  as List<WorkoutSet>,
        isTimeBased: null == isTimeBased
            ? _value.isTimeBased
            : isTimeBased // ignore: cast_nullable_to_non_nullable
                  as bool,
        exerciseId: freezed == exerciseId
            ? _value.exerciseId
            : exerciseId // ignore: cast_nullable_to_non_nullable
                  as String?,
        slotId: freezed == slotId
            ? _value.slotId
            : slotId // ignore: cast_nullable_to_non_nullable
                  as String?,
        originalName: freezed == originalName
            ? _value.originalName
            : originalName // ignore: cast_nullable_to_non_nullable
                  as String?,
        sessionModified: null == sessionModified
            ? _value.sessionModified
            : sessionModified // ignore: cast_nullable_to_non_nullable
                  as bool,
        keepInTemplate: null == keepInTemplate
            ? _value.keepInTemplate
            : keepInTemplate // ignore: cast_nullable_to_non_nullable
                  as bool,
        variants: freezed == variants
            ? _value._variants
            : variants // ignore: cast_nullable_to_non_nullable
                  as List<WorkoutVariant>?,
        activeVariantIndex: freezed == activeVariantIndex
            ? _value.activeVariantIndex
            : activeVariantIndex // ignore: cast_nullable_to_non_nullable
                  as int?,
        supersetGroupId: freezed == supersetGroupId
            ? _value.supersetGroupId
            : supersetGroupId // ignore: cast_nullable_to_non_nullable
                  as String?,
        supersetPosition: freezed == supersetPosition
            ? _value.supersetPosition
            : supersetPosition // ignore: cast_nullable_to_non_nullable
                  as int?,
        supersetSize: freezed == supersetSize
            ? _value.supersetSize
            : supersetSize // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutExerciseImpl extends _WorkoutExercise {
  const _$WorkoutExerciseImpl({
    required this.id,
    required this.name,
    required this.notes,
    required this.tempo,
    required this.restTime,
    required final List<WorkoutSet> sets,
    this.isTimeBased = false,
    this.exerciseId,
    this.slotId,
    this.originalName,
    this.sessionModified = false,
    this.keepInTemplate = false,
    final List<WorkoutVariant>? variants,
    this.activeVariantIndex,
    this.supersetGroupId,
    this.supersetPosition,
    this.supersetSize,
  }) : _sets = sets,
       _variants = variants,
       super._();

  factory _$WorkoutExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutExerciseImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String notes;
  @override
  final String tempo;
  @override
  final int restTime;
  final List<WorkoutSet> _sets;
  @override
  List<WorkoutSet> get sets {
    if (_sets is EqualUnmodifiableListView) return _sets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sets);
  }

  @override
  @JsonKey()
  final bool isTimeBased;

  /// Catalog identity, when known. `null` for an exercise typed by hand in
  /// session — the history lookup then falls back to the normalized name.
  @override
  final String? exerciseId;
  @override
  final String? slotId;
  @override
  final String? originalName;
  @override
  @JsonKey()
  final bool sessionModified;

  /// The user asked for this exercise, as it now stands, to be written back
  /// to the template when the session ends. Off by default: a change made
  /// mid-session is for today only unless said otherwise.
  @override
  @JsonKey()
  final bool keepInTemplate;
  final List<WorkoutVariant>? _variants;
  @override
  List<WorkoutVariant>? get variants {
    final value = _variants;
    if (value == null) return null;
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? activeVariantIndex;
  @override
  final String? supersetGroupId;
  @override
  final int? supersetPosition;
  @override
  final int? supersetSize;

  @override
  String toString() {
    return 'WorkoutExercise(id: $id, name: $name, notes: $notes, tempo: $tempo, restTime: $restTime, sets: $sets, isTimeBased: $isTimeBased, exerciseId: $exerciseId, slotId: $slotId, originalName: $originalName, sessionModified: $sessionModified, keepInTemplate: $keepInTemplate, variants: $variants, activeVariantIndex: $activeVariantIndex, supersetGroupId: $supersetGroupId, supersetPosition: $supersetPosition, supersetSize: $supersetSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.tempo, tempo) || other.tempo == tempo) &&
            (identical(other.restTime, restTime) ||
                other.restTime == restTime) &&
            const DeepCollectionEquality().equals(other._sets, _sets) &&
            (identical(other.isTimeBased, isTimeBased) ||
                other.isTimeBased == isTimeBased) &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.slotId, slotId) || other.slotId == slotId) &&
            (identical(other.originalName, originalName) ||
                other.originalName == originalName) &&
            (identical(other.sessionModified, sessionModified) ||
                other.sessionModified == sessionModified) &&
            (identical(other.keepInTemplate, keepInTemplate) ||
                other.keepInTemplate == keepInTemplate) &&
            const DeepCollectionEquality().equals(other._variants, _variants) &&
            (identical(other.activeVariantIndex, activeVariantIndex) ||
                other.activeVariantIndex == activeVariantIndex) &&
            (identical(other.supersetGroupId, supersetGroupId) ||
                other.supersetGroupId == supersetGroupId) &&
            (identical(other.supersetPosition, supersetPosition) ||
                other.supersetPosition == supersetPosition) &&
            (identical(other.supersetSize, supersetSize) ||
                other.supersetSize == supersetSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    notes,
    tempo,
    restTime,
    const DeepCollectionEquality().hash(_sets),
    isTimeBased,
    exerciseId,
    slotId,
    originalName,
    sessionModified,
    keepInTemplate,
    const DeepCollectionEquality().hash(_variants),
    activeVariantIndex,
    supersetGroupId,
    supersetPosition,
    supersetSize,
  );

  /// Create a copy of WorkoutExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutExerciseImplCopyWith<_$WorkoutExerciseImpl> get copyWith =>
      __$$WorkoutExerciseImplCopyWithImpl<_$WorkoutExerciseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutExerciseImplToJson(this);
  }
}

abstract class _WorkoutExercise extends WorkoutExercise {
  const factory _WorkoutExercise({
    required final String id,
    required final String name,
    required final String notes,
    required final String tempo,
    required final int restTime,
    required final List<WorkoutSet> sets,
    final bool isTimeBased,
    final String? exerciseId,
    final String? slotId,
    final String? originalName,
    final bool sessionModified,
    final bool keepInTemplate,
    final List<WorkoutVariant>? variants,
    final int? activeVariantIndex,
    final String? supersetGroupId,
    final int? supersetPosition,
    final int? supersetSize,
  }) = _$WorkoutExerciseImpl;
  const _WorkoutExercise._() : super._();

  factory _WorkoutExercise.fromJson(Map<String, dynamic> json) =
      _$WorkoutExerciseImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get notes;
  @override
  String get tempo;
  @override
  int get restTime;
  @override
  List<WorkoutSet> get sets;
  @override
  bool get isTimeBased;

  /// Catalog identity, when known. `null` for an exercise typed by hand in
  /// session — the history lookup then falls back to the normalized name.
  @override
  String? get exerciseId;
  @override
  String? get slotId;
  @override
  String? get originalName;
  @override
  bool get sessionModified;

  /// The user asked for this exercise, as it now stands, to be written back
  /// to the template when the session ends. Off by default: a change made
  /// mid-session is for today only unless said otherwise.
  @override
  bool get keepInTemplate;
  @override
  List<WorkoutVariant>? get variants;
  @override
  int? get activeVariantIndex;
  @override
  String? get supersetGroupId;
  @override
  int? get supersetPosition;
  @override
  int? get supersetSize;

  /// Create a copy of WorkoutExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutExerciseImplCopyWith<_$WorkoutExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
