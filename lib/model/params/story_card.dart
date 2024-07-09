import 'package:chat_app/model/entities/story.dart';

class StoryCard {
  String? idUser;
  String? avatar;
  String? name;
  bool? activeStatus;
  List<Story>? listStory;

  StoryCard({this.idUser, this.avatar, this.name,this.activeStatus, this.listStory});
}
