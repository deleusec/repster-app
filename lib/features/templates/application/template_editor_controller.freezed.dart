// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_editor_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TemplateEditorState {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<MuscleGroup> get tags => throw _privateConstructorUsedError;
  List<TemplateSlot> get slots => throw _privateConstructorUsedError;

  /// Create a copy of TemplateEditorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TemplateEditorStateCopyWith<TemplateEditorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TemplateEditorStateCopyWith<$Res> {
  factory $TemplateEditorStateCopyWith(
    TemplateEditorState value,
    $Res Function(TemplateEditorState) then,
  ) = _$TemplateEditorStateCopyWithImpl<$Res, TemplateEditorState>;
  @useResult
  $Res call({
    String name,
    String description,
    List<MuscleGroup> tags,
    List<TemplateSlot> slots,
  });
}

/// @nodoc
class _$TemplateEditorStateCopyWithImpl<$Res, $Val extends TemplateEditorState>
    implements $TemplateEditorStateCopyWith<$Res> {
  _$TemplateEditorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TemplateEditorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? tags = null,
    Object? slots = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<MuscleGroup>,
            slots: null == slots
                ? _value.slots
                : slots // ignore: cast_nullable_to_non_nullable
                      as List<TemplateSlot>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TemplateEditorStateImplCopyWith<$Res>
    implements $TemplateEditorStateCopyWith<$Res> {
  factory _$$TemplateEditorStateImplCopyWith(
    _$TemplateEditorStateImpl value,
    $Res Function(_$TemplateEditorStateImpl) then,
  ) = __$$TemplateEditorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String description,
    List<MuscleGroup> tags,
    List<TemplateSlot> slots,
  });
}

/// @nodoc
class __$$TemplateEditorStateImplCopyWithImpl<$Res>
    extends _$TemplateEditorStateCopyWithImpl<$Res, _$TemplateEditorStateImpl>
    implements _$$TemplateEditorStateImplCopyWith<$Res> {
  __$$TemplateEditorStateImplCopyWithImpl(
    _$TemplateEditorStateImpl _value,
    $Res Function(_$TemplateEditorStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TemplateEditorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? tags = null,
    Object? slots = null,
  }) {
    return _then(
      _$TemplateEditorStateImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<MuscleGroup>,
        slots: null == slots
            ? _value._slots
            : slots // ignore: cast_nullable_to_non_nullable
                  as List<TemplateSlot>,
      ),
    );
  }
}

/// @nodoc

class _$TemplateEditorStateImpl extends _TemplateEditorState {
  const _$TemplateEditorStateImpl({
    required this.name,
    required this.description,
    required final List<MuscleGroup> tags,
    required final List<TemplateSlot> slots,
  }) : _tags = tags,
       _slots = slots,
       super._();

  @override
  final String name;
  @override
  final String description;
  final List<MuscleGroup> _tags;
  @override
  List<MuscleGroup> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<TemplateSlot> _slots;
  @override
  List<TemplateSlot> get slots {
    if (_slots is EqualUnmodifiableListView) return _slots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_slots);
  }

  @override
  String toString() {
    return 'TemplateEditorState(name: $name, description: $description, tags: $tags, slots: $slots)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TemplateEditorStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._slots, _slots));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    description,
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_slots),
  );

  /// Create a copy of TemplateEditorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TemplateEditorStateImplCopyWith<_$TemplateEditorStateImpl> get copyWith =>
      __$$TemplateEditorStateImplCopyWithImpl<_$TemplateEditorStateImpl>(
        this,
        _$identity,
      );
}

abstract class _TemplateEditorState extends TemplateEditorState {
  const factory _TemplateEditorState({
    required final String name,
    required final String description,
    required final List<MuscleGroup> tags,
    required final List<TemplateSlot> slots,
  }) = _$TemplateEditorStateImpl;
  const _TemplateEditorState._() : super._();

  @override
  String get name;
  @override
  String get description;
  @override
  List<MuscleGroup> get tags;
  @override
  List<TemplateSlot> get slots;

  /// Create a copy of TemplateEditorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TemplateEditorStateImplCopyWith<_$TemplateEditorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
