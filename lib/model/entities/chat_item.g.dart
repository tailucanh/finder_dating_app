// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatItem _$ChatItemFromJson(Map<String, dynamic> json) => ChatItem(
      json['id'] as String,
      json['uId01'] as String,
      json['uId02'] as String,
      json['lastMessage'] as String?,
      json['createAt'] as String?,
    );

Map<String, dynamic> _$ChatItemToJson(ChatItem instance) => <String, dynamic>{
      'id': instance.id,
      'uId01': instance.uId01,
      'uId02': instance.uId02,
      'lastMessage': instance.lastMessage,
      'createAt': instance.createAt,
    };
