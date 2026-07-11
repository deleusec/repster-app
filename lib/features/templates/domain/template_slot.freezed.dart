// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TemplateSlot {
  String get slotId => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  bool get supersetWithNext => throw _privateConstructorUsedError;
  List<TemplateExercise> get variants => throw _privateConstructorUsedError;

  /// Create a copy of TemplateSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TemplateSlotCopyWith<TemplateSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TemplateSlotCopyWith<$Res> {
  factory $TemplateSlotCopyWith(
    TemplateSlot value,
    $Res Function(TemplateSlot) then,
  ) = _$TemplateSlotCopyWithImpl<$Res, TemplateSlot>;
  @useResult
  $Res call({
    String slotId,
    int order,
    bool supersetWithNext,
    List<TemplateExercise> variants,
  });
}

/// @nodoc
class _$TemplateSlotCopyWithImpl<$Res, $Val extends TemplateSlot>
    implements $TemplateSlotCopyWith<$Res> {
  _$TemplateSlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TemplateSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slotId = null,
    Object? order = null,
    Object? supersetWithNext = null,
    Object? variants = null,
  }) {
    return _then(
      _value.copyWith(
            slotId: null == slotId
                ? _value.slotId
                : slotId // ignore: cast_nullable_to_non_nullable
                      as String,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
            supersetWithNext: null == supersetWithNext
                ? _value.supersetWithNext
                : supersetWithNext // ignore: cast_nullable_to_non_nullable
                      as bool,
            variants: null == variants
                ? _value.variants
                : variants // ignore: cast_nullable_to_non_nullable
                      as List<TemplateExercise>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TemplateSlotImplCopyWith<$Res>
    implements $TemplateSlotCopyWith<$Res> {
  factory _$$TemplateSlotImplCopyWith(
    _$TemplateSlotImpl value,
    $Res Function(_$TemplateSlotImpl) then,
  ) = __$$TemplateSlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String slotId,
    int order,
    bool supersetWithNext,
    List<TemplateExercise> variants,
  });
}

/// @nodoc
class __$$TemplateSlotImplCopyWithImpl<$Res>
    extends _$TemplateSlotCopyWithImpl<$Res, _$TemplateSlotImpl>
    implements _$$TemplateSlotImplCopyWith<$Res> {
  __$$TemplateSlotImplCopyWithImpl(
    _$TemplateSlotImpl _value,
    $Res Function(_$TemplateSlotImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TemplateSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slotId = null,
    Object? order = null,
    Object? supersetWithNext = null,
    Object? variants = null,
  }) {
    return _then(
      _$TemplateSlotImpl(
        slotId: null == slotId
            ? _value.slotId
            : slotId // ignore: cast_nullable_to_non_nullable
                  as String,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
        supersetWithNext: null == supersetWithNext
            ? _value.supersetWithNext
            : supersetWithNext // ignore: cast_nullable_to_non_nullable
                  as bool,
        variants: null == variants
            ? _value._variants
            : variants // ignore: cast_nullable_to_non_nullable
                  as List<TemplateExercise>,
      ),
    );
  }
}

/// @nodoc

class _$TemplateSlotImpl extends _TemplateSlot {
  const _$TemplateSlotImpl({
    required this.slotId,
    required this.order,
    required this.supersetWithNext,
    required final List<TemplateExercise> variants,
  }) : _variants = variants,
       super._();

  @override
  final String slotId;
  @override
  final int order;
  @override
  final bool supersetWithNext;
  final List<TemplateExercise> _variants;
  @override
  List<TemplateExercise> get variants {
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variants);
  }

  @override
  String toString() {
    return 'TemplateSlot(slotId: $slotId, order: $order, supersetWithNext: $supersetWithNext, variants: $variants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TemplateSlotImpl &&
            (identical(other.slotId, slotId) || other.slotId == slotId) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.supersetWithNext, supersetWithNext) ||
                other.supersetWithNext == supersetWithNext) &&
            const DeepCollectionEquality().equals(other._variants, _variants));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    slotId,
    order,
    supersetWithNext,
    const DeepCollectionEquality().hash(_variants),
  );

  /// Create a copy of TemplateSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TemplateSlotImplCopyWith<_$TemplateSlotImpl> get copyWith =>
      __$$TemplateSlotImplCopyWithImpl<_$TemplateSlotImpl>(this, _$identity);
}

abstract class _TemplateSlot extends TemplateSlot {
  const factory _TemplateSlot({
    required final String slotId,
    required final int order,
    required final bool supersetWithNext,
    required final List<TemplateExercise> variants,
  }) = _$TemplateSlotImpl;
  const _TemplateSlot._() : super._();

  @override
  String get slotId;
  @override
  int get order;
  @override
  bool get supersetWithNext;
  @override
  List<TemplateExercise> get variants;

  /// Create a copy of TemplateSlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TemplateSlotImplCopyWith<_$TemplateSlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
