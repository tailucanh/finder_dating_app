import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../config/helpers/helpers_database.dart';
import 'profile_screen_navigator.dart';

part 'profile_screen_state.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  final ProfileScreenNavigator navigator;

  final userRepository = getIt<UserRepository>();

  ProfileScreenCubit({
    required this.navigator,
  }) : super(const ProfileScreenState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final user = await userRepository.getOneUser(id: helpersFunctions.idUser);
      final isProfileVerified = await userRepository.checkVerification();
      emit(state.copyWith(
          loadDataStatus: LoadStatus.success,
          user: user,
          isProfileVerified: isProfileVerified));
    } catch (e) {
      //Todo: should print exception here
      debugPrint(e.toString());
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void goToSetting() {
    navigator.goToSetting();
  }
}
