import 'dart:developer';

import 'package:chat_app/di/network_repository.dart';
import 'package:chat_app/model/entities/user_entity.dart';
import 'package:chat_app/model/enums/load_state.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'who_love_navigator.dart';

part 'who_love_state.dart';

class WhoLoveCubit extends Cubit<WhoLoveState> {
  final WhoLoveNavigator navigator;
  final userRepository = getIt<UserRepository>();

  WhoLoveCubit({
    required this.navigator,
  }) : super(const WhoLoveState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final userFollowers = await userRepository.getUserFollowers();
      final isPrimary = await userRepository.getPrimaryGold();
      log("message $isPrimary");
      emit(state.copyWith(
          loadDataStatus: LoadStatus.success,
          userFollowers: userFollowers,
          isPrimaryGold: isPrimary));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
