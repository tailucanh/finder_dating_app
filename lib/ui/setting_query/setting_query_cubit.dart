import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../generated/l10n.dart';

part 'setting_query_state.dart';

class SettingQueryCubit extends Cubit<SettingQueryState> {
  SettingQueryCubit() : super(const SettingQueryState());
  final userRepository = getIt<UserRepository>();

  List<String> requestToShowList() {
    return <String>[
      S().gender_male,
      S().gender_female,
      S().gender_other,
    ];
  }

  Future<void> updateRequestToShow() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      await userRepository.updateRequestToShow();
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void updateMaxPhoto(double value) {
    helpersFunctions.maxPhoto = value;
    emit(state.copyWith(maxPhoto: value));
  }

  void updateInterest(int value) {
    helpersFunctions.interests = value;
    emit(state.copyWith(interests: value));
  }

  void updateZodiac(int value) {
    helpersFunctions.zodiac = value;
    emit(state.copyWith(zodiac: value));
  }

  void updateEdu(int value) {
    helpersFunctions.education = value;
    emit(state.copyWith(education: value));
  }

  void updateFamily(int value) {
    helpersFunctions.futureFamily = value;
    emit(state.copyWith(futureFamily: value));
  }

  void updatePerson(int value) {
    helpersFunctions.personType = value;
    emit(state.copyWith(personalityType: value));
  }

  void updateCommunication(int value) {
    helpersFunctions.communicationStyle = value;
    emit(state.copyWith(communication: value));
  }

  void updateLove(int value) {
    helpersFunctions.loveLanguage = value;
    emit(state.copyWith(loveLanguage: value));
  }

  void updatePets(int value) {
    helpersFunctions.pets = value;
    emit(state.copyWith(pets: value));
  }

  void updateAlcohol(int value) {
    helpersFunctions.alcoholConsumption = value;
    emit(state.copyWith(alcoholConsumption: value));
  }

  void updateSmoke(int value) {
    helpersFunctions.smoke = value;
    emit(state.copyWith(smoke: value));
  }

  void updateExercise(int value) {
    helpersFunctions.exercise = value;
    emit(state.copyWith(exercise: value));
  }

  void updateDietary(int value) {
    helpersFunctions.dietaryHabit = value;
    emit(state.copyWith(dietary: value));
  }

  void updateSleep(int value) {
    helpersFunctions.sleepHabits = value;
    emit(state.copyWith(sleep: value));
  }
}
