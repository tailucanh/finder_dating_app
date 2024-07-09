// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      token: json['to'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      notification: json['notification'] == null
          ? null
          : ItemNotification.fromJson(
              json['notification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'to': instance.token,
      'data': instance.data,
      'notification': instance.notification,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      type: json['type'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
    };

ItemNotification _$ItemNotificationFromJson(Map<String, dynamic> json) =>
    ItemNotification(
      json['title'] as String?,
      json['body'] as String?,
    );

Map<String, dynamic> _$ItemNotificationToJson(ItemNotification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
    };
