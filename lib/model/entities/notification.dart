import 'package:json_annotation/json_annotation.dart';
part 'notification.g.dart';

@JsonSerializable()
class Notification {
  @JsonKey(name: 'to')
  String? token;
  @JsonKey(name: 'data')
  Data? data;
  @JsonKey(name: 'notification')
  ItemNotification? notification;

  Notification({this.token, this.data, this.notification});

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}

@JsonSerializable()
class Data {
  String? type;
  String? id;

  Data({this.type, this.id});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class ItemNotification {
  String? title;
  String? body;

  ItemNotification(this.title, this.body);
  factory ItemNotification.fromJson(Map<String, dynamic> json) =>
      _$ItemNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$ItemNotificationToJson(this);
}
