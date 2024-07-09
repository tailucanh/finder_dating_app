import 'package:json_annotation/json_annotation.dart';
part 'user_time.g.dart';

@JsonSerializable()
class UserTimeEntity {
  String uid;
  String time;

  UserTimeEntity({required this.uid, required this.time});

  factory UserTimeEntity.fromJson(Map<String, dynamic> json) =>
      _$UserTimeEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserTimeEntityToJson(this);
}
