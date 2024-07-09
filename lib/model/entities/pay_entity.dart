import 'package:json_annotation/json_annotation.dart';
part 'pay_entity.g.dart';

@JsonSerializable()
class PayEntity {
  String? id;
  String? email;
  String? name;
  String? address;
  String? payee;
  String? createTime;
  String? amount;
  String? currency;
  String? payment_mode;
  String? description;
  String? typePay;

  PayEntity(
      {this.id,
      this.email,
      this.name,
      this.address,
      this.payee,
      this.createTime,
      this.amount,
      this.currency,
      this.payment_mode,
      this.description,
      this.typePay
      });

  factory PayEntity.fromJson(Map<String, dynamic> json) =>
      _$PayEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PayEntityToJson(this);
}
