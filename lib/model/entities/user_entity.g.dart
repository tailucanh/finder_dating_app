// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      uid: json['uid'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      fullName: json['fullName'] as String,
      uidCall: json['uidCall'] as String,
      birthday: json['birthday'] as String,
      avatar: json['avatar'] as String,
      gender: json['gender'] as int,
      requestToShow: json['requestToShow'] as int,
      datingPurpose: json['datingPurpose'] as int,
      introduceYourself: json['introduceYourself'] as String?,
      school: json['school'] as String?,
      followersList: (json['followersList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      photoList:
          (json['photoList'] as List<dynamic>).map((e) => e as String).toList(),
      interestsList: (json['interestsList'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      fluentLanguageList: (json['fluentLanguageList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sexualOrientationList: (json['sexualOrientationList'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      likeList: (json['likeList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      disLikeList: (json['disLikeList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      company: json['company'] as String?,
      currentAddress: json['currentAddress'] as String?,
      activeStatus: json['activeStatus'] as bool?,
      height: json['height'] as int?,
      zodiac: json['zodiac'] as int?,
      academicLever: json['academicLever'] as int?,
      communicateStyle: json['communicateStyle'] as int?,
      languageOfLove: json['languageOfLove'] as int?,
      familyStyle: json['familyStyle'] as int?,
      personalityType: json['personalityType'] as String?,
      myPet: json['myPet'] as int?,
      drinkingStatus: json['drinkingStatus'] as int?,
      smokingStatus: json['smokingStatus'] as int?,
      sportsStatus: json['sportsStatus'] as int?,
      eatingStatus: json['eatingStatus'] as int?,
      socialNetworkStatus: json['socialNetworkStatus'] as int?,
      sleepingHabits: json['sleepingHabits'] as int?,
      spotify: json['spotify'] == null
          ? null
          : SpotifyInformationEntity.fromJson(
              json['spotify'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'uidCall': instance.uidCall,
      'email': instance.email,
      'phone': instance.phone,
      'fullName': instance.fullName,
      'birthday': instance.birthday,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'requestToShow': instance.requestToShow,
      'datingPurpose': instance.datingPurpose,
      'school': instance.school,
      'introduceYourself': instance.introduceYourself,
      'followersList': instance.followersList,
      'photoList': instance.photoList,
      'interestsList': instance.interestsList,
      'fluentLanguageList': instance.fluentLanguageList,
      'sexualOrientationList': instance.sexualOrientationList,
      'likeList': instance.likeList,
      'disLikeList': instance.disLikeList,
      'company': instance.company,
      'currentAddress': instance.currentAddress,
      'activeStatus': instance.activeStatus,
      'height': instance.height,
      'zodiac': instance.zodiac,
      'academicLever': instance.academicLever,
      'communicateStyle': instance.communicateStyle,
      'languageOfLove': instance.languageOfLove,
      'familyStyle': instance.familyStyle,
      'personalityType': instance.personalityType,
      'myPet': instance.myPet,
      'drinkingStatus': instance.drinkingStatus,
      'smokingStatus': instance.smokingStatus,
      'sportsStatus': instance.sportsStatus,
      'eatingStatus': instance.eatingStatus,
      'socialNetworkStatus': instance.socialNetworkStatus,
      'sleepingHabits': instance.sleepingHabits,
      'spotify': instance.spotify,
    };
