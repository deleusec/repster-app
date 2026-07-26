// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_perf.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LastPerfImpl _$$LastPerfImplFromJson(Map<String, dynamic> json) =>
    _$LastPerfImpl(
      reps: (json['reps'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
      seconds: (json['seconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$LastPerfImplToJson(_$LastPerfImpl instance) =>
    <String, dynamic>{
      'reps': instance.reps,
      'weight': instance.weight,
      'seconds': instance.seconds,
    };

_$LastPerfMetaImpl _$$LastPerfMetaImplFromJson(Map<String, dynamic> json) =>
    _$LastPerfMetaImpl(
      performedAt: json['performedAt'] == null
          ? null
          : DateTime.parse(json['performedAt'] as String),
      target: (json['target'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$LastPerfMetaImplToJson(_$LastPerfMetaImpl instance) =>
    <String, dynamic>{
      'performedAt': instance.performedAt?.toIso8601String(),
      'target': instance.target,
    };
