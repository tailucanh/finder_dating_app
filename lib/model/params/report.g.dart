// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      idUser: json['idUser'] as String?,
      idUserReport: json['idUserReport'] as String?,
      createAt: json['createAt'] as int?,
      reasonTitle: json['reasonTitle'] as String?,
      reasonDetail: json['reasonDetail'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'idUser': instance.idUser,
      'idUserReport': instance.idUserReport,
      'createAt': instance.createAt,
      'reasonTitle': instance.reasonTitle,
      'reasonDetail': instance.reasonDetail,
      'content': instance.content,
    };
