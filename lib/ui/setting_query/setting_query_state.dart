part of 'setting_query_cubit.dart';

class SettingQueryState extends Equatable {
  final LoadStatus loadDataStatus;

  final double? maxPhoto;
  final int? interests;
  final int? lookingFor;
  final int? zodiac;
  final int? education;
  final int? futureFamily;
  final int? personalityType;
  final int? communication;
  final int? loveLanguage;
  final int? pets;
  final int? alcoholConsumption;
  final int? smoke;
  final int? exercise;
  final int? dietary;
  final int? sleep;

  const SettingQueryState({
    this.loadDataStatus = LoadStatus.initial,
    this.interests,
    this.maxPhoto,
    this.lookingFor,
    this.zodiac,
    this.education,
    this.futureFamily,
    this.personalityType,
    this.communication,
    this.loveLanguage,
    this.pets,
    this.alcoholConsumption,
    this.smoke,
    this.exercise,
    this.dietary,
    this.sleep,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        interests,
        maxPhoto,
        lookingFor,
        loveLanguage,
        sleep,
        zodiac,
        dietary,
        exercise,
        smoke,
        alcoholConsumption,
        personalityType,
        pets,
        futureFamily,
        education
      ];

  SettingQueryState copyWith({
    LoadStatus? loadDataStatus,
    double? maxPhoto,
    int? interests,
    int? lookingFor,
    int? zodiac,
    int? education,
    int? futureFamily,
    int? personalityType,
    int? communication,
    int? loveLanguage,
    int? pets,
    int? alcoholConsumption,
    int? smoke,
    int? exercise,
    int? dietary,
    int? sleep,
  }) {
    return SettingQueryState(
        loadDataStatus: loadDataStatus ?? this.loadDataStatus,
        alcoholConsumption: alcoholConsumption ?? this.alcoholConsumption,
        communication: communication ?? this.communication,
        dietary: dietary ?? this.dietary,
        education: education ?? this.education,
        exercise: exercise ?? this.exercise,
        futureFamily: futureFamily ?? this.futureFamily,
        interests: interests ?? this.interests,
        lookingFor: lookingFor ?? this.lookingFor,
        loveLanguage: loveLanguage ?? this.loveLanguage,
        personalityType: personalityType ?? this.personalityType,
        pets: pets ?? this.pets,
        sleep: sleep ?? this.sleep,
        smoke: smoke ?? this.sleep,
        zodiac: zodiac ?? this.zodiac,
        maxPhoto: maxPhoto ?? this.maxPhoto);
  }
}
