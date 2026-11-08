// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutSessionImpl _$$WorkoutSessionImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutSessionImpl(
      id: json['id'] as String,
      templateId: json['templateId'] as String,
      templateName: json['templateName'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      duration: (json['duration'] as num).toInt(),
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => WorkoutExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$$WorkoutSessionImplToJson(
  _$WorkoutSessionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'templateId': instance.templateId,
  'templateName': instance.templateName,
  'startedAt': instance.startedAt.toIso8601String(),
  'duration': instance.duration,
  'exercises': instance.exercises,
  'notes': instance.notes,
};
