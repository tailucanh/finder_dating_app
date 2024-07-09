import 'package:json_annotation/json_annotation.dart';
part 'story.g.dart';

@JsonSerializable()
class Story {
  String? url;
  String? createAt;
  String? id;

  Story({this.url, this.createAt, this.id});

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);

//
}
