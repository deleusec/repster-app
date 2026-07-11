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
      isFallback: json['isFallback'] as bool? ?? false,
      originalTarget: (json['originalTarget'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$LastPerfMetaImplToJson(_$LastPerfMetaImpl instance) =>
    <String, dynamic>{
      'isFallback': instance.isFallback,
      'originalTarget': instance.originalTarget,
    };
