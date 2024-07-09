// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayEntity _$PayEntityFromJson(Map<String, dynamic> json) => PayEntity(
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      payee: json['payee'] as String?,
      createTime: json['createTime'] as String?,
      amount: json['amount'] as String?,
      currency: json['currency'] as String?,
      payment_mode: json['payment_mode'] as String?,
      description: json['description'] as String?,
      typePay: json['typePay'] as String?,
    );

Map<String, dynamic> _$PayEntityToJson(PayEntity instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'address': instance.address,
      'payee': instance.payee,
      'createTime': instance.createTime,
      'amount': instance.amount,
      'currency': instance.currency,
      'payment_mode': instance.payment_mode,
      'description': instance.description,
      'typePay': instance.typePay
    };
