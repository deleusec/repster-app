// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutSetImpl _$$WorkoutSetImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutSetImpl(
      id: json['id'] as String,
      setNumber: (json['setNumber'] as num).toInt(),
      targetReps: (json['targetReps'] as num).toInt(),
      actualReps: (json['actualReps'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
      completed: json['completed'] as bool,
      targetSeconds: (json['targetSeconds'] as num?)?.toInt(),
      actualSeconds: (json['actualSeconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$WorkoutSetImplToJson(_$WorkoutSetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'setNumber': instance.setNumber,
      'targetReps': instance.targetReps,
      'actualReps': instance.actualReps,
      'weight': instance.weight,
      'completed': instance.completed,
      'targetSeconds': instance.targetSeconds,
      'actualSeconds': instance.actualSeconds,
    };
