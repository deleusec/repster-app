// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'last_perf.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LastPerf _$LastPerfFromJson(Map<String, dynamic> json) {
  return _LastPerf.fromJson(json);
}

/// @nodoc
mixin _$LastPerf {
  int get reps => throw _privateConstructorUsedError;
  double get weight => throw _privateConstructorUsedError;
  int? get seconds => throw _privateConstructorUsedError;

  /// Serializes this LastPerf to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LastPerf
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LastPerfCopyWith<LastPerf> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastPerfCopyWith<$Res> {
  factory $LastPerfCopyWith(LastPerf value, $Res Function(LastPerf) then) =
      _$LastPerfCopyWithImpl<$Res, LastPerf>;
  @useResult
  $Res call({int reps, double weight, int? seconds});
}

/// @nodoc
class _$LastPerfCopyWithImpl<$Res, $Val extends LastPerf>
    implements $LastPerfCopyWith<$Res> {
  _$LastPerfCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LastPerf
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reps = null,
    Object? weight = null,
    Object? seconds = freezed,
  }) {
    return _then(
      _value.copyWith(
            reps: null == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                      as int,
            weight: null == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as double,
            seconds: freezed == seconds
                ? _value.seconds
                : seconds // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LastPerfImplCopyWith<$Res>
    implements $LastPerfCopyWith<$Res> {
  factory _$$LastPerfImplCopyWith(
    _$LastPerfImpl value,
    $Res Function(_$LastPerfImpl) then,
  ) = __$$LastPerfImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int reps, double weight, int? seconds});
}

/// @nodoc
class __$$LastPerfImplCopyWithImpl<$Res>
    extends _$LastPerfCopyWithImpl<$Res, _$LastPerfImpl>
    implements _$$LastPerfImplCopyWith<$Res> {
  __$$LastPerfImplCopyWithImpl(
    _$LastPerfImpl _value,
    $Res Function(_$LastPerfImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LastPerf
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reps = null,
    Object? weight = null,
    Object? seconds = freezed,
  }) {
    return _then(
      _$LastPerfImpl(
        reps: null == reps
            ? _value.reps
            : reps // ignore: cast_nullable_to_non_nullable
                  as int,
        weight: null == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as double,
        seconds: freezed == seconds
            ? _value.seconds
            : seconds // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LastPerfImpl extends _LastPerf {
  const _$LastPerfImpl({required this.reps, required this.weight, this.seconds})
    : super._();

  factory _$LastPerfImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastPerfImplFromJson(json);

  @override
  final int reps;
  @override
  final double weight;
  @override
  final int? seconds;

  @override
  String toString() {
    return 'LastPerf(reps: $reps, weight: $weight, seconds: $seconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastPerfImpl &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.seconds, seconds) || other.seconds == seconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reps, weight, seconds);

  /// Create a copy of LastPerf
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LastPerfImplCopyWith<_$LastPerfImpl> get copyWith =>
      __$$LastPerfImplCopyWithImpl<_$LastPerfImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LastPerfImplToJson(this);
  }
}

abstract class _LastPerf extends LastPerf {
  const factory _LastPerf({
    required final int reps,
    required final double weight,
    final int? seconds,
  }) = _$LastPerfImpl;
  const _LastPerf._() : super._();

  factory _LastPerf.fromJson(Map<String, dynamic> json) =
      _$LastPerfImpl.fromJson;

  @override
  int get reps;
  @override
  double get weight;
  @override
  int? get seconds;

  /// Create a copy of LastPerf
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LastPerfImplCopyWith<_$LastPerfImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LastPerfMeta _$LastPerfMetaFromJson(Map<String, dynamic> json) {
  return _LastPerfMeta.fromJson(json);
}

/// @nodoc
mixin _$LastPerfMeta {
  DateTime? get performedAt => throw _privateConstructorUsedError;
  int? get target => throw _privateConstructorUsedError;

  /// True when the reference comes from a past run of *this* workout. False
  /// means it was picked up from another workout, which the UI says out loud:
  /// the same exercise placed elsewhere in the week is not the same effort.
  bool get fromSameWorkout => throw _privateConstructorUsedError;

  /// Serializes this LastPerfMeta to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LastPerfMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LastPerfMetaCopyWith<LastPerfMeta> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastPerfMetaCopyWith<$Res> {
  factory $LastPerfMetaCopyWith(
    LastPerfMeta value,
    $Res Function(LastPerfMeta) then,
  ) = _$LastPerfMetaCopyWithImpl<$Res, LastPerfMeta>;
  @useResult
  $Res call({DateTime? performedAt, int? target, bool fromSameWorkout});
}

/// @nodoc
class _$LastPerfMetaCopyWithImpl<$Res, $Val extends LastPerfMeta>
    implements $LastPerfMetaCopyWith<$Res> {
  _$LastPerfMetaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LastPerfMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? performedAt = freezed,
    Object? target = freezed,
    Object? fromSameWorkout = null,
  }) {
    return _then(
      _value.copyWith(
            performedAt: freezed == performedAt
                ? _value.performedAt
                : performedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            target: freezed == target
                ? _value.target
                : target // ignore: cast_nullable_to_non_nullable
                      as int?,
            fromSameWorkout: null == fromSameWorkout
                ? _value.fromSameWorkout
                : fromSameWorkout // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LastPerfMetaImplCopyWith<$Res>
    implements $LastPerfMetaCopyWith<$Res> {
  factory _$$LastPerfMetaImplCopyWith(
    _$LastPerfMetaImpl value,
    $Res Function(_$LastPerfMetaImpl) then,
  ) = __$$LastPerfMetaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? performedAt, int? target, bool fromSameWorkout});
}

/// @nodoc
class __$$LastPerfMetaImplCopyWithImpl<$Res>
    extends _$LastPerfMetaCopyWithImpl<$Res, _$LastPerfMetaImpl>
    implements _$$LastPerfMetaImplCopyWith<$Res> {
  __$$LastPerfMetaImplCopyWithImpl(
    _$LastPerfMetaImpl _value,
    $Res Function(_$LastPerfMetaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LastPerfMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? performedAt = freezed,
    Object? target = freezed,
    Object? fromSameWorkout = null,
  }) {
    return _then(
      _$LastPerfMetaImpl(
        performedAt: freezed == performedAt
            ? _value.performedAt
            : performedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        target: freezed == target
            ? _value.target
            : target // ignore: cast_nullable_to_non_nullable
                  as int?,
        fromSameWorkout: null == fromSameWorkout
            ? _value.fromSameWorkout
            : fromSameWorkout // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LastPerfMetaImpl extends _LastPerfMeta {
  const _$LastPerfMetaImpl({
    this.performedAt,
    this.target,
    this.fromSameWorkout = false,
  }) : super._();

  factory _$LastPerfMetaImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastPerfMetaImplFromJson(json);

  @override
  final DateTime? performedAt;
  @override
  final int? target;

  /// True when the reference comes from a past run of *this* workout. False
  /// means it was picked up from another workout, which the UI says out loud:
  /// the same exercise placed elsewhere in the week is not the same effort.
  @override
  @JsonKey()
  final bool fromSameWorkout;

  @override
  String toString() {
    return 'LastPerfMeta(performedAt: $performedAt, target: $target, fromSameWorkout: $fromSameWorkout)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastPerfMetaImpl &&
            (identical(other.performedAt, performedAt) ||
                other.performedAt == performedAt) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.fromSameWorkout, fromSameWorkout) ||
                other.fromSameWorkout == fromSameWorkout));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, performedAt, target, fromSameWorkout);

  /// Create a copy of LastPerfMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LastPerfMetaImplCopyWith<_$LastPerfMetaImpl> get copyWith =>
      __$$LastPerfMetaImplCopyWithImpl<_$LastPerfMetaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LastPerfMetaImplToJson(this);
  }
}

abstract class _LastPerfMeta extends LastPerfMeta {
  const factory _LastPerfMeta({
    final DateTime? performedAt,
    final int? target,
    final bool fromSameWorkout,
  }) = _$LastPerfMetaImpl;
  const _LastPerfMeta._() : super._();

  factory _LastPerfMeta.fromJson(Map<String, dynamic> json) =
      _$LastPerfMetaImpl.fromJson;

  @override
  DateTime? get performedAt;
  @override
  int? get target;

  /// True when the reference comes from a past run of *this* workout. False
  /// means it was picked up from another workout, which the UI says out loud:
  /// the same exercise placed elsewhere in the week is not the same effort.
  @override
  bool get fromSameWorkout;

  /// Create a copy of LastPerfMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LastPerfMetaImplCopyWith<_$LastPerfMetaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
