import 'package:json_annotation/json_annotation.dart';
part 'chat_item.g.dart';

@JsonSerializable()
class ChatItem {
  final String id;
  final String uId01;
  final String uId02;
  final String? lastMessage;
  final String? createAt;

  ChatItem(this.id, this.uId01, this.uId02, this.lastMessage, this.createAt);

  factory ChatItem.fromJson(Map<String, dynamic> json) =>
      _$ChatItemFromJson(json);

  Map<String, dynamic> toJson() => _$ChatItemToJson(this);
}
