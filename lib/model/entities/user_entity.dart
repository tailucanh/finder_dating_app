import 'package:json_annotation/json_annotation.dart';

import 'spotify_information_entity.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  String uid;
  String uidCall;
  String email;
  String phone;
  String fullName;
  String birthday;
  String avatar;
  int gender;
  int requestToShow;
  int datingPurpose;
  String? school;
  String? introduceYourself;
  List<String> followersList;
  List<String> photoList;
  List<int> interestsList;
  List<String>? fluentLanguageList;
  List<int> sexualOrientationList;
  List<String>? likeList;
  List<String>? disLikeList;
  String? company;
  String? currentAddress;

  bool? activeStatus;
  int? height;

//BasicInfoUser
  int? zodiac;
  int? academicLever;
  int? communicateStyle;
  int? languageOfLove;
  int? familyStyle;
  String? personalityType;

  //StyleOfLifeUser
  int? myPet;
  int? drinkingStatus;
  int? smokingStatus;
  int? sportsStatus;
  int? eatingStatus;
  int? socialNetworkStatus;
  int? sleepingHabits;

  SpotifyInformationEntity? spotify;

  UserEntity(
      {required this.uid,
      required this.email,
      required this.phone,
      required this.fullName,
      required this.uidCall,
      required this.birthday,
      required this.avatar,
      required this.gender,
      required this.requestToShow,
      required this.datingPurpose,
      required this.introduceYourself,
      required this.school,
      required this.followersList,
      required this.photoList,
      required this.interestsList,
      required this.fluentLanguageList,
      required this.sexualOrientationList,
      required this.likeList,
      required this.disLikeList,
      required this.company,
      required this.currentAddress,
      required this.activeStatus,
      this.height,
      this.zodiac,
      this.academicLever,
      this.communicateStyle,
      this.languageOfLove,
      this.familyStyle,
      this.personalityType,
      this.myPet,
      this.drinkingStatus,
      this.smokingStatus,
      this.sportsStatus,
      this.eatingStatus,
      this.socialNetworkStatus,
      this.sleepingHabits, this.spotify
      });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
