// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutVariantImpl _$$WorkoutVariantImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutVariantImpl(
      name: json['name'] as String,
      sets: (json['sets'] as num).toInt(),
      reps: (json['reps'] as num).toInt(),
      tempo: json['tempo'] as String,
      restTime: (json['restTime'] as num).toInt(),
      notes: json['notes'] as String,
      isTimeBased: json['isTimeBased'] as bool? ?? false,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
      exerciseId: json['exerciseId'] as String?,
    );

Map<String, dynamic> _$$WorkoutVariantImplToJson(
  _$WorkoutVariantImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'sets': instance.sets,
  'reps': instance.reps,
  'tempo': instance.tempo,
  'restTime': instance.restTime,
  'notes': instance.notes,
  'isTimeBased': instance.isTimeBased,
  'durationSeconds': instance.durationSeconds,
  'exerciseId': instance.exerciseId,
};

_$WorkoutExerciseImpl _$$WorkoutExerciseImplFromJson(
  Map<String, dynamic> json,
) => _$WorkoutExerciseImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  notes: json['notes'] as String,
  tempo: json['tempo'] as String,
  restTime: (json['restTime'] as num).toInt(),
  sets: (json['sets'] as List<dynamic>)
      .map((e) => WorkoutSet.fromJson(e as Map<String, dynamic>))
      .toList(),
  isTimeBased: json['isTimeBased'] as bool? ?? false,
  exerciseId: json['exerciseId'] as String?,
  slotId: json['slotId'] as String?,
  originalName: json['originalName'] as String?,
  sessionModified: json['sessionModified'] as bool? ?? false,
  keepInTemplate: json['keepInTemplate'] as bool? ?? false,
  variants: (json['variants'] as List<dynamic>?)
      ?.map((e) => WorkoutVariant.fromJson(e as Map<String, dynamic>))
      .toList(),
  activeVariantIndex: (json['activeVariantIndex'] as num?)?.toInt(),
  supersetGroupId: json['supersetGroupId'] as String?,
  supersetPosition: (json['supersetPosition'] as num?)?.toInt(),
  supersetSize: (json['supersetSize'] as num?)?.toInt(),
);

Map<String, dynamic> _$$WorkoutExerciseImplToJson(
  _$WorkoutExerciseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'notes': instance.notes,
  'tempo': instance.tempo,
  'restTime': instance.restTime,
  'sets': instance.sets,
  'isTimeBased': instance.isTimeBased,
  'exerciseId': instance.exerciseId,
  'slotId': instance.slotId,
  'originalName': instance.originalName,
  'sessionModified': instance.sessionModified,
  'keepInTemplate': instance.keepInTemplate,
  'variants': instance.variants,
  'activeVariantIndex': instance.activeVariantIndex,
  'supersetGroupId': instance.supersetGroupId,
  'supersetPosition': instance.supersetPosition,
  'supersetSize': instance.supersetSize,
};
