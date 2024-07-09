part of 'update_profile_cubit.dart';

class UpdateProfileState extends Equatable {
  final LoadStatus loadDataStatus;
  final int? gender;
  final int? datingPurpose;
  final String? school;
  final String? introduceYourself;
  final List<String>? followersList;
  final List<String>? photoList;
  final List<int>? interestsList;
  final List<String>? fluentLanguageList;
  final String? company;
  final String? currentAddress;
  final int? height;

//BasicInfoUser
  final int? zodiac;
  final int? academicLever;
  final int? communicateStyle;
  final int? languageOfLove;
  final int? familyStyle;
  final String? personalityType;

  //StyleOfLifeUser
  final int? myPet;
  final int? drinkingStatus;
  final int? smokingStatus;
  final int? sportsStatus;
  final int? eatingStatus;
  final int? socialNetworkStatus;
  final int? sleepingHabits;
  final SpotifyInformationEntity? spotifyInformation;

  const UpdateProfileState({
    this.loadDataStatus = LoadStatus.initial,
    this.gender,
    this.datingPurpose,
    this.school,
    this.introduceYourself,
    this.followersList,
    this.photoList,
    this.interestsList,
    this.fluentLanguageList,
    this.company,
    this.currentAddress,
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
    this.sleepingHabits,
    this.spotifyInformation,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        gender,
        datingPurpose,
        school,
        introduceYourself,
        photoList,
        interestsList,
        fluentLanguageList,
        company,
        currentAddress,
        zodiac,
        height,
        academicLever,
        communicateStyle,
        languageOfLove,
        familyStyle,
        personalityType,
        myPet,
        drinkingStatus,
        smokingStatus,
        sportsStatus,
        eatingStatus,
        socialNetworkStatus,
        sleepingHabits,
       spotifyInformation,
      ];

  UpdateProfileState copyWith({
    LoadStatus? loadDataStatus,
    int? gender,
    int? datingPurpose,
    String? school,
    String? introduceYourself,
    List<String>? followersList,
    List<String>? photoList,
    List<int>? interestsList,
    List<String>? fluentLanguageList,
    String? company,
    String? currentAddress,
    int? height,
//BasicInfoUser
    int? zodiac,
    int? academicLever,
    int? communicateStyle,
    int? languageOfLove,
    int? familyStyle,
    String? personalityType,

    //StyleOfLifeUser
    int? myPet,
    int? drinkingStatus,
    int? smokingStatus,
    int? sportsStatus,
    int? eatingStatus,
    int? socialNetworkStatus,
    int? sleepingHabits,
    SpotifyInformationEntity? spotifyInformation,
  }) {
    return UpdateProfileState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      gender: gender ?? this.gender,
      datingPurpose: datingPurpose ?? this.datingPurpose,
      school: school ?? this.school,
      introduceYourself: introduceYourself ?? this.introduceYourself,
      photoList: photoList ?? this.photoList,
      interestsList: interestsList ?? this.interestsList,
      fluentLanguageList: fluentLanguageList ?? this.fluentLanguageList,
      company: company ?? this.company,
      currentAddress: currentAddress ?? this.currentAddress,
      zodiac: zodiac ?? this.zodiac,
      height: height ?? this.height,
      academicLever: academicLever ?? this.academicLever,
      communicateStyle: communicateStyle ?? this.communicateStyle,
      languageOfLove: languageOfLove ?? this.languageOfLove,
      familyStyle: familyStyle ?? this.familyStyle,
      personalityType: personalityType ?? this.personalityType,
      myPet: myPet ?? this.myPet,
      drinkingStatus: drinkingStatus ?? this.drinkingStatus,
      smokingStatus: smokingStatus ?? this.smokingStatus,
      sportsStatus: sportsStatus ?? this.sportsStatus,
      eatingStatus: eatingStatus ?? this.eatingStatus,
      socialNetworkStatus: socialNetworkStatus ?? this.socialNetworkStatus,
      sleepingHabits: sleepingHabits ?? this.sleepingHabits,
      spotifyInformation: spotifyInformation ?? this.spotifyInformation,
    );
  }
}
