// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tokens _$TokensFromJson(Map<String, dynamic> json) => Tokens(
      idUser: json['idUser'] as String?,
      token: json['token'] as String?,
      timeActive: json['timeActive'] as int?,
      time: json['time'] as int?,
      isProfileVerified: json['isProfileVerified'] as bool?,
    );

Map<String, dynamic> _$TokensToJson(Tokens instance) => <String, dynamic>{
      'idUser': instance.idUser,
      'token': instance.token,
      'timeActive': instance.timeActive,
      'time': instance.time,
      'isProfileVerified': instance.isProfileVerified,
    };
