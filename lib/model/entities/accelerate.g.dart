// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accelerate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Accelerate _$AccelerateFromJson(Map<String, dynamic> json) => Accelerate(
      turn: json['turn'] as int?,
      priority: json['priority'] as String?,
      createAt: json['createAt'] as String?,
      endAt: json['endAt'] as String?,
      uid: json['uid'] as String?,
      timeEnd: json['timeEnd'] as String?,
      timeStart: json['timeStart'] as String?,
    );

Map<String, dynamic> _$AccelerateToJson(Accelerate instance) =>
    <String, dynamic>{
      'turn': instance.turn,
      'priority': instance.priority,
      'uid': instance.uid,
      'createAt': instance.createAt,
      'endAt': instance.endAt,
      'timeStart': instance.timeStart,
      'timeEnd': instance.timeEnd,
    };
